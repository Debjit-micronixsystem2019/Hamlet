//
//  FNAlert.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

class HTAlert {
    class func showAlertWithOptions(title: String?, message: String?, firstButtonTitle: String?, secondButtonTitle: String?, thirdButtonTitle: String?, controller: UIViewController, completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let firstButtonTitle = firstButtonTitle {
            alertController.addAction(UIAlertAction(title: firstButtonTitle, style: .default) { _ in
                completion(firstButtonTitle)
            })
        }
        
        if let secondButtonTitle = secondButtonTitle {
            alertController.addAction(UIAlertAction(title: secondButtonTitle, style: .default) { _ in
                completion(secondButtonTitle)
            })
        }
        
        if let thirdButtonTitle = thirdButtonTitle {
            alertController.addAction(UIAlertAction(title: thirdButtonTitle, style: .default) { _ in
                completion(thirdButtonTitle)
            })
        }
        
        alertController.addAction(UIAlertAction(title: Constants.cancel, style: .cancel) { _ in
            completion(Constants.cancel)
        })
        
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithTitle(title: String?, message: String?, controller: UIViewController, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.ok, style: .default) { _ in
            completion?()
        })
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithTextField(title: String?, message: String?, placeholder: String = "", controller: UIViewController, completion: ((String) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = placeholder
            textField.keyboardType = .decimalPad
        }
        alertController.addAction(UIAlertAction(title: Constants.ok, style: .default) { _ in
            guard let textField = alertController.textFields?.first, let text = textField.text else {
                completion?("")
                return
            }
            completion?(text)
        })
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func showLogWeightAlert(title: String?, message: String?, controller: UIViewController, completion: ((String) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Weight"
            textField.keyboardType = .numberPad
        }
        
        let okAction = UIAlertAction(title: Constants.ok, style: .default) { _ in
            guard let textField = alertController.textFields?.first, let text = textField.text else {
                completion?("")
                return
            }
            completion?(text)
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
    }
}
