//
//  EmailVerifyVC.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class EmailVerifyVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var emailVerifyButton: UIButton!
    @IBOutlet weak var emailVerifyView: UIView!
    var emailText = ""
    var passwordText = ""
    
    // MARK: - IBAction
    @IBAction func emailButtonAction (_ sender : UIButton) {
        requestEmailVerify(otp: Int(otpTextField.text!) ?? 0, email: emailText)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var emailVerifyVM = EmailVerifyViewModel()
    var logInVM = LoginViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        otpTextField.delegate = self
        emailVerifyView.layer.cornerRadius = 10
        emailVerifyButton.layer.cornerRadius = 25
    }
    
    private func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    // MARK: - Data Received From VM
    private func requestEmailVerify(otp: Int, email : String) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        emailVerifyVM.requestEmailVerify( with: otp, email: email) { [weak self] (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                self?.sendLogInData(email : self?.emailText ?? "" , password : self?.passwordText ?? "")
                
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
    
    // MARK: - Send Data To VM From UI
    func sendLogInData(email : String, password : String) {
        if (email.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        }else if (password.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        }else{
            DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
            logInVM.requestLogin(email: email, password: password) { [weak self] (result) in
                switch result {
                case .success:
                    guard let data = self?.logInVM.loginResponse else { return }
                    self?.saveLoginFlag()
                    self?.saveFlagForFirstLaunch()
                    if data.user?.userTypeID == 1 { // Trainer or Coach
                        self?.navigateToCoachTabView()
                    } else {
                        self?.navigateToUserTabView()
                    }
                case .failure(let error):
                    print(error.description)
                    DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                    HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                }
            }
        }
    }
    
    // MARK: - Private Methods -
    private func saveLoginFlag() {
        UserDefaults.standard.setValue(true, forKey: Defaults.loggedIn)
    }
    private func saveAuthToken(with token: String) {
        Authentication().saveToken(token: token)
    }
    private func saveFlagForFirstLaunch() {
        if let data = self.logInVM.loginResponse {
            Authentication().saveToken(token: data.token ?? "")
            UserDefaults.standard.setValue(data.user?.id, forKey: Defaults.userId)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: - Navigation To Coach UI
    func navigateToCoachTabView(){
        DispatchQueue.main.async {  MBProgressHUD.hide(for: self.view, animated: true) }
        let mainStoryBoard = UIStoryboard(name: "CoachTabBar", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "CoachTabBarController") as! CoachTabBarController
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    // MARK: - Navigation To User UI
    func navigateToUserTabView(){
        DispatchQueue.main.async {  MBProgressHUD.hide(for: self.view, animated: true) }
        let mainStoryBoard = UIStoryboard(name: "SelectProblem", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "SelectProblemVC") as! SelectProblemVC
        
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


