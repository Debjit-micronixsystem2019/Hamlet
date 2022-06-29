//
//  NotificationViewController.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.

import UIKit
import MBProgressHUD

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var notificationListVM = NotificationListViewModel()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        if screenHeight < 700 {
            topConstraint.constant = 20
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if screenHeight < 700 {
            topConstraint.constant = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationListService()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        notificationListService()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Data Received From VM
    private func notificationListService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        notificationListVM.requestAllNotificationList{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
               /* if let details = self?.notificationListVM.notificationListResponse {
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

