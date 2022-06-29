//
//  UIViewController.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import ACFloatingTextfield_Swift

extension UIViewController{
    
    //MARK:- For UIView Shadow
    func boderShadow(view: UIView,shadowRadius: Float,shadowOpacity: Float,viewcorner: Float) {
    //        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
            view.layer.shadowRadius = CGFloat(shadowRadius)
            view.layer.shadowOffset = .zero
            view.layer.shadowOpacity = shadowOpacity
            view.layer.cornerRadius = CGFloat(viewcorner)
        }
    
    //MARK:- For UIButton radiousCorner
    func submitButton(name : UIButton, radiousCorner : Float)  {
        name.layer.cornerRadius = CGFloat(radiousCorner)
    }
    
    //MARK:- For Email Validation
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    //MARK:- For Valid Password
    func validPassword(mypassword : String) -> Bool {
        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
    
    //MARK:- For Show Hud
    func showHud(_ message: String = AlertConstants.loading) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    
    //MARK:- For Hide Hud
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    //MARK:- For Shaw Error Message In TextField
    func shawErrorMSG(txtField : ACFloatingTextfield, error : String){
        txtField.errorTextColor = UIColor.red
        txtField.errorLineColor = UIColor.red
        txtField.showErrorWithText(errorText: error)
    }
    
    //MARK:- For Hide Keyboard In UIView
    func hideKeyboardWhenTappedAround(_ VC : UIViewController) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK:- TextView Boder Light
    func textViewBoderlight(txtVW : UITextView) {
        txtVW.layer.cornerRadius = 6.0
        txtVW.layer.borderWidth = 0.2
        txtVW.layer.borderColor = UIColor.lightGray.cgColor
       }
    //MARK:- For Shaw Error Message In UIView
    func showAlertMessage(alertType : fixedAlert.Alert, title : String? = AlertFromApi.projectAlert, message : String? = AlertFromApi.message)  {
        
        var alertController = UIAlertController()
            switch alertType {
                 case .noInternet:
                    alertController = UIAlertController(title: AlertConstants.projectAlert , message: AlertConstants.noInternet, preferredStyle: .alert)
                 case .login:
                    alertController = UIAlertController(title: AlertConstants.projectAlert , message: AlertConstants.fillDetail, preferredStyle: .alert)
                case .faildJson:
                    alertController = UIAlertController(title: AlertConstants.projectAlert , message: AlertConstants.faildAPiData, preferredStyle: .alert)
                 case .nil:
                     alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            }
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
       
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

}

