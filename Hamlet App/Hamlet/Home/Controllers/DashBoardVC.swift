//
//  DashBoardVC.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class DashBoardVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var communityButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBOutlet
    @IBAction func postButtonAction (_ sender : UIButton) {
        postButton.backgroundColor = #colorLiteral(red: 0.819162786, green: 0.1134349331, blue: 0.2118148208, alpha: 1)
        communityButton.backgroundColor = #colorLiteral(red: 0.8665875793, green: 0.8667157292, blue: 0.8665712476, alpha: 1)
        postButton.setTitleColor(UIColor.white, for: .normal)
        communityButton.setTitleColor(UIColor.darkGray, for: .normal)
        postANDcommunityButtonTap = true
        tableView.reloadData()
    }
    
    @IBAction func communityButtonAction (_ sender : UIButton) {
        communityButton.backgroundColor = #colorLiteral(red: 0.819162786, green: 0.1134349331, blue: 0.2118148208, alpha: 1)
        postButton.backgroundColor = #colorLiteral(red: 0.8665875793, green: 0.8667157292, blue: 0.8665712476, alpha: 1)
        communityButton.setTitleColor(UIColor.white, for: .normal)
        postButton.setTitleColor(UIColor.darkGray, for: .normal)
        postANDcommunityButtonTap = false
        tableView.reloadData()
        communityService()
    }
    
    // MARK: - Variables
    var postANDcommunityButtonTap : Bool = true
    var DashBoardVM = DashBoardViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        postButton.layer.cornerRadius = 25
        communityButton.layer.cornerRadius = 25
        postButton.backgroundColor = #colorLiteral(red: 0.819162786, green: 0.1134349331, blue: 0.2118148208, alpha: 1)
        communityButton.backgroundColor = #colorLiteral(red: 0.8665875793, green: 0.8667157292, blue: 0.8665712476, alpha: 1)
        postButton.setTitleColor(UIColor.white, for: .normal)
        communityButton.setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    
        // MARK: - Send Data To VM From UI
  
    
    private func communityService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        DashBoardVM.requestCommunityDetails{ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.DashBoardVM.communityDetails {
                    print("Data: ",details)
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
        
    

    
 /*   private func setupUI() {
        tableView.tableFooterView = UIView()
        notificationButton.layer.cornerRadius = 20
        notificationButton.clipsToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func paymentHistoryService() {
        homeVM.requestPaymentHistory(userId: Int(AppSettings.shared.userId) ?? 0) { [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.homeVM.paymentHistory {
                    print("Data: ",details)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.description)
                JMTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
            }
            DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
        }
    }
    
    private func rentDetailsService() {
        homeVM.requestRentList(userId: Int(AppSettings.shared.userId) ?? 0) { [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.homeVM.rentDetails {
                    print("Collection view Data: ",details)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.description)
                JMTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
            }
        }
    }*/
    
}

