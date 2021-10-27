//
//  LogInVC.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
//import ACFloatingTextfield_Swift
import Toast_Swift
import MBProgressHUD

class LoginVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var submitBTN : UIButton!
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    // MARK: - IBActions
    @IBAction func submitBTNActn (_ sender : UIButton){
        sendLogInData(email : usernameTextField.text ?? "", password : passwordTextField.text ?? "")
       // self.navigateToTabView()
    }
    
    @IBAction func signUpBTNActn (_ sender : UIButton){
        let mainStoryBoard = UIStoryboard(name: "Registration", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    // MARK: - Variables
    var logInVM = LoginViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      //  logInVM.vc = self
        SetUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Set UI
    func SetUI() {
        usernameTextField.setTextFieldShadow()
        usernameTextField.setLeftPadding(46)
        passwordTextField.setTextFieldShadow()
        passwordTextField.setLeftPadding(46)

        
        submitButton(name : submitBTN, radiousCorner : 25)
//        passwordTextField.placeholder = "Password"
//        passwordTextField.layer.cornerRadius = 25
//        passwordTextField.layer.borderWidth = 0.5
//        passwordTextField.layer.borderColor = UIColor.black.cgColor
//        passwordTxtFld.placeHolderColor = UIColor.gray
//        passwordTxtFld.selectedPlaceHolderColor = UIColor(named: "ColorPButtonBackground")!
//        userNameTxtFld.layer.cornerRadius = 25
//        userNameTxtFld.placeholder = "Email"
//        userNameTxtFld.placeHolderColor = UIColor.gray
//        userNameTxtFld.selectedPlaceHolderColor = UIColor(named: "ColorPButtonBackground")!
        TxtFiedDelegate()
        hideKeyboardWhenTappedAround(self)
    }
    
    // MARK: - Send Data To VM From UI
    func sendLogInData(email : String, password : String) {
//        navigateToTabView()
        if (email.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        }else if (password.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        }else{
            DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
            logInVM.requestLogin(email: email, password: password) { [weak self] (result) in
                switch result {
                case .success:
                    self?.saveLoginFlag()
                    self?.saveFlagForFirstLaunch()
                    self?.navigateToTabView()
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
//            UserDefaults.standard.setValue(data.id, forKey: Defaults.userId)
//            UserDefaults.standard.setValue(data.name, forKey: Defaults.userName)
//            UserDefaults.standard.setValue(data.email, forKey: Defaults.userEmail)
//            UserDefaults.standard.setValue(data.profileImageURL, forKey: Defaults.userProfileUrl)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: - Navigation To Next UI
    func navigateToTabView(){
        DispatchQueue.main.async {  MBProgressHUD.hide(for: self.view, animated: true) }
        let mainStoryBoard = UIStoryboard(name: "TabBar", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Enter email", message: "Please enter email id", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "email"
            //Copy alertTextField in local variable to use in current block of code
            textField = alertTextField
        }
        
        let actionSend = UIAlertAction(title: "Send", style: .default) { action in
            //Prints the alertTextField's value
            print(textField.text!)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        alert.addAction(actionSend)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Text Field Delegate
extension  LoginVC: UITextFieldDelegate {
    func TxtFiedDelegate(){
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
