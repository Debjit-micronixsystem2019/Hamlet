//
//  RegistrationVC.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import Toast_Swift
import MBProgressHUD

class RegistrationVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var submitBTN : UIButton!
    @IBOutlet weak var checkBTN : UIButton!
    @IBOutlet weak var passwordSeeBTN : UIButton!
    @IBOutlet weak var confirmPasswordSeeBTN : UIButton!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var genderTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var phoneTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var confirmPasswordTextField : UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var chatLanguageTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var userTypeId = 2
    let datePicker = UIDatePicker()
    
    // MARK: - IBActions
    @IBAction func submitBTNActn (_ sender : UIButton) {
        sendRegistrationData(userType: userTypeId, name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, dob: dobTextField.text!, gender: genderTextField.text!, phone: Int(phoneTextField.text!) ?? 0, countryId: countryID, chatLanguageId: languageID, profilePicture: "")
    }
    
    @IBAction func signInBTNActn (_ sender : UIButton) {
        let mainStoryBoard = UIStoryboard(name: "LogIn", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            userTypeId = 2
        } else if segmentedControl.selectedSegmentIndex == 1 {
            userTypeId = 1
        }
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        if sender.isSelected{
            checkBTN.isSelected = false
        }else{
            checkBTN.isSelected = true
        }
    }
    
    @IBAction func passwordSeeButtonAction(_ sender: UIButton) {
        if sender.isSelected{
            passwordSeeBTN.isSelected = false
            passwordTextField.isSecureTextEntry = true
        }else{
            passwordSeeBTN.isSelected = true
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    @IBAction func confirmPasswordSeeButtonAction(_ sender: UIButton) {
        if sender.isSelected{
            confirmPasswordSeeBTN.isSelected = false
            confirmPasswordTextField.isSecureTextEntry = true
            
        }else{
            confirmPasswordSeeBTN.isSelected = true
            confirmPasswordTextField.isSecureTextEntry = false
        }
    }
    
    // MARK: - Variables
    var registrationVM: RegistrationViewModel?
    var countryListVM = CountryListViewModel()
    var languageListVM = LanguageListViewModel()
    var countryID : Int = 1
    var countryArray = [String]()
    var languageID : Int = 1
    var languageArray = [String]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //   registrationVM.vc = self
        SetUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - SetupUI
    func SetUI() {
        showDatePicker()
        submitButton(name : submitBTN, radiousCorner : 25)
        hideKeyboardWhenTappedAround(self)
        nameTextField.setTextFieldShadow()
        nameTextField.setLeftPadding(46)
        genderTextField.setTextFieldShadow()
        genderTextField.setLeftPadding(46)
        emailTextField.setTextFieldShadow()
        emailTextField.setLeftPadding(46)
        phoneTextField.setTextFieldShadow()
        phoneTextField.setLeftPadding(46)
        dobTextField.setTextFieldShadow()
        dobTextField.setLeftPadding(46)
        countryTextField.setTextFieldShadow()
        countryTextField.setLeftPadding(46)
        chatLanguageTextField.setTextFieldShadow()
        chatLanguageTextField.setLeftPadding(46)
        passwordTextField.setTextFieldShadow()
        passwordTextField.setLeftPadding(46)
        confirmPasswordTextField.setTextFieldShadow()
        confirmPasswordTextField.setLeftPadding(46)
        checkBTN.layer.cornerRadius = 3
        checkBTN.layer.borderWidth = 0.5
        checkBTN.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Send Data To VM From UI
    
    private func getLanguageListData() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        languageListVM.requestLanguageList{ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.languageListVM.languageListResponse {
                   // print("Data: ",details)
                    self?.languageArray.removeAll()
                   for (_,item) in details.enumerated(){
                        self?.languageArray.append(item.name ?? "")
                    }
                    
                    let itemsTitle = self?.languageArray
                    let popupPickerView = AYPopupPickerView()
                    popupPickerView.display(itemTitles: itemsTitle ?? [], doneHandler: { [self] in
                        let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                       // print(itemsTitle?[selectedIndex])
                        self?.chatLanguageTextField.text = itemsTitle?[selectedIndex]
                        self?.languageID = details[selectedIndex].id ?? 1
                    })
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
    
    private func getCountryListData() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        countryListVM.requestCountryList{ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.countryListVM.countryListResponse {
                   // print("Data: ",details)
                    self?.countryArray.removeAll()
                   for (_,item) in details.enumerated(){
                        self?.countryArray.append(item.name ?? "")
                    }
                    
                    let itemsTitle = self?.countryArray
                    let popupPickerView = AYPopupPickerView()
                    popupPickerView.display(itemTitles: itemsTitle ?? [], doneHandler: { [self] in
                        let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                       // print(itemsTitle?[selectedIndex])
                        self?.countryTextField.text = itemsTitle?[selectedIndex]
                        self?.countryID = details[selectedIndex].id ?? 1
                    })
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
    
    
    func sendRegistrationData(userType: Int, name: String, email: String, password: String, dob: String, gender: String, phone: Int, countryId: Int, chatLanguageId: Int, profilePicture: String) {
        let validPass = validPassword(mypassword: passwordTextField.text ?? "")
        
        if (name.trimmingCharacters(in: .whitespaces).isEmpty) {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        } else if (email.trimmingCharacters(in: .whitespaces).isEmpty) {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        } else if (name.trimmingCharacters(in: .whitespaces).isEmpty) {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        }  else if (password.trimmingCharacters(in: .whitespaces).isEmpty) {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        } else if passwordTextField.text != confirmPasswordTextField.text {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.doesNotMatchPassword, controller: self, completion: nil)
        } else if (validPass == false) {
            AlertFromApi.message = AlertConstants.nonValidPassword
            self.showAlertMessage(alertType: .nil)
        } else {
            if isValidEmail(email: emailTextField.text ?? "") {
                self.view.endEditing(true)
                DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
                let requestBody = SignupRequestModel(userType: userType, name: name, email: email, password: password, dob: dob, gender: gender, phone: phone, countryId: countryId, chatLanguageId: chatLanguageId, profilePicture: profilePicture)
                self.registrationVM = RegistrationViewModel(requestBody: requestBody)
                self.registrationVM?.requestSignup(completion: { [weak self] (result) in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                        self?.emailVerifyView()
//                        self?.saveLoginFlag()
//                        self?.saveFlagForFirstLaunch()
//                        self?.uiNavigation()
                    case .failure(let error):
                        print(error.description)
                        DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                        HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                    }
                })
            } else {
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self.view, animated: true) }
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.invalidEmail, controller: self, completion: nil)
            }
        }
    }
    
    // MARK: - Email Verify View
    func emailVerifyView(){
       let mainStoryBoard = UIStoryboard(name: "EmailVerify", bundle: nil)
         let vc = mainStoryBoard.instantiateViewController(withIdentifier: "EmailVerifyVC") as! EmailVerifyVC
        vc.modalPresentationStyle = .overFullScreen
        vc.emailText = emailTextField.text!
        vc.passwordText = passwordTextField.text!
        self.present(vc, animated: true, completion: nil)
    }

    // MARK: - Navigation To Next UI
    func uiNavigation() {
        DispatchQueue.main.async {  MBProgressHUD.hide(for: self.view, animated: true) }
        let mainStoryBoard = UIStoryboard(name: "TabBar", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    // MARK: - Private Methods -
    private func saveLoginFlag() {
        UserDefaults.standard.setValue(true, forKey: Defaults.loggedIn)
    }
    
    private func saveFlagForFirstLaunch() {
        if let data = self.registrationVM?.signupResponse {
            UserDefaults.standard.setValue(data.id, forKey: Defaults.userId)
            UserDefaults.standard.setValue(data.name, forKey: Defaults.userName)
            UserDefaults.standard.setValue(data.email, forKey: Defaults.userEmail)
            UserDefaults.standard.setValue(data.chatLanguageID, forKey: Defaults.userChatLanguageId)
            UserDefaults.standard.synchronize()
        }
    }
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dobTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

}

// MARK: - Text Field Delegate
extension  RegistrationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /*if textField == FirstNameTxtFld {
         userNameTxtFld.becomeFirstResponder()
         }else if textField == userNameTxtFld {
         EmailTxtFld.becomeFirstResponder()
         }else if textField == EmailTxtFld {
         PhNumberTxtFld.becomeFirstResponder()
         }else if textField == PhNumberTxtFld {
         PasswordTxtFld.becomeFirstResponder()
         }else if textField == PasswordTxtFld {
         ConfirmPasswordTxtFld.becomeFirstResponder()
         }else {
         ConfirmPasswordTxtFld.resignFirstResponder()
         }*/
        textField.becomeFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(textField.tag)
//        if textField.tag == 2 {
//            textField.inputView = datePickerView
//            return true
//        }else
        if textField.tag == 3 {
            self.view.endEditing(true)
            let itemsTitle = ["Male", "Female", "Rather not say", "Custom"]
            let popupPickerView = AYPopupPickerView()
            popupPickerView.display(itemTitles: itemsTitle, doneHandler: { [self] in
                let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
                print(itemsTitle[selectedIndex])
                self.genderTextField.text = itemsTitle[selectedIndex]
            })
        } else if textField.tag == 5 {
            self.view.endEditing(true)
             getCountryListData()
        } else if textField.tag == 6 {
            self.view.endEditing(true)
            getLanguageListData()
        }
        return false
    }
}
