//
//  HelpViewController.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var textFieldbackView : UIView!
    @IBOutlet weak var commentTextView : UITextView!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var phoneTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var submitButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        boderShadow(view: textFieldbackView, shadowRadius: 9, shadowOpacity: 0.2, viewcorner: 10)
        submitButton.layer.cornerRadius = 10
        textViewBoderlight(txtVW: commentTextView)
    }
}
