//
//  SelectProblemInSearchSectionVC.swift
//  Hamlet
//
//  Created by admin on 11/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class SelectProblemInSearchSectionVC: UIViewController {

 // MARK: - IBOutlet
    @IBOutlet weak var dissmissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backView: UIView!

    // MARK: - IBAction
    @IBAction func dissmissButtonAction (_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var selectProblemListVM = SelectProblemListViewModel()
    var selectProblemID : ((Int,String)->())!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        selectProblemListService()
        backView.layer.cornerRadius = 20
    }
    
    // MARK: - Data Received From VM
    private func selectProblemListService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        selectProblemListVM.requestSelectProblemList{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
               /* if let details = self?.selectProblemListVM.selectProblemResponse {
                    print("Data: ",details)
                }*/
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
}
