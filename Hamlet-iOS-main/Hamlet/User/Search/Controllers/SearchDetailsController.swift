//
//  SearchDetailsController.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class SearchDetailsController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var newEntryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    private func setupUI() {
        boderShadow(view: shadowView, shadowRadius: 9, shadowOpacity: 0.2, viewcorner: 10)
        submitButton(name: newEntryButton, radiousCorner: 10)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
