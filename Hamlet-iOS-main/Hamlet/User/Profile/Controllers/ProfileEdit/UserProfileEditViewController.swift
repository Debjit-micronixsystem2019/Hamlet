//
//  UserProfileEditViewController.swift
//  Hamlet
//
//  Created by admin on 5/18/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import Toast_Swift
import MBProgressHUD

class UserProfileEditViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var submitBTN : UIButton!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var genderTextField : UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func submitBTNActn (_ sender : UIButton) {
        sendProfileEditData(id: user_id,
                            name: nameTextField.text!,
                            dob: dobTextField.text!,
                            gender: genderTextField.text!)
    }
    
    // MARK: - Variables
    let datePicker = UIDatePicker()
    var profileEditVM = ProfileEditViewModel()
    var user_name = String()
    var user_dob = String()
    var user_gender = String()
    var user_id = Int()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //   self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //  self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - SetupUI
    func SetUI() {
        
      /*  print("user_name",user_name)
        print("user_dob",user_dob)
        print("user_gender",user_gender)
        print("user_id",user_id)*/

        
        self.title = "Profile Edit"
        showDatePicker()
        submitButton(name : submitBTN, radiousCorner : 25)
        hideKeyboardWhenTappedAround(self)
        nameTextField.setTextFieldShadow()
        nameTextField.setLeftPadding(46)
        genderTextField.setTextFieldShadow()
        genderTextField.setLeftPadding(46)
        dobTextField.setTextFieldShadow()
        dobTextField.setLeftPadding(46)
        nameTextField.text = user_name
        genderTextField.text = user_gender
        dobTextField.text = user_dob
    }
    
    // MARK: - Send Data To VM From UI
    
    func sendProfileEditData(id: Int, name: String, dob: String, gender: String) {
        
        if (name.trimmingCharacters(in: .whitespaces).isEmpty) {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        } else if (dob.trimmingCharacters(in: .whitespaces).isEmpty) {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        } else if (gender.trimmingCharacters(in: .whitespaces).isEmpty) {
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.textFieldBlank, controller: self, completion: nil)
        } else {
             self.view.endEditing(true)
             DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
            profileEditVM.requestForProfileEditData(with: id, name: name, dob: dob, gender: gender){ [weak self] (result) in
                switch result {
                case .success:
                    if let details = self?.profileEditVM.editProileResponce {
                        print("Data: ",details)
                    }
                    HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: AlertConstants.profileUpdate, controller: self!, completion: nil)
                    DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                case .failure(let error):
                    print(error.description)
                    HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                    DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                }
            }
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
extension  UserProfileEditViewController: UITextFieldDelegate {
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
        }
        return false
    }
}

