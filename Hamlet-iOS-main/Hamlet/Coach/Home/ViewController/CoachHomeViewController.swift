//
//  CoachHomeViewController.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class CoachHomeViewController: UIViewController {
    
   // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    var bookingListVM = BookingListViewModel()
    let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if screenHeight < 700 {
            topConstraint.constant = 30
        }
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        bookingListService()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        bookingListService()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Request Data To VM From UI
    func bookingListService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        bookingListVM.requestMyBookingList{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
               /* if let details = self?.bookingListVM.myBookingListResponse {
                    print("Data: ",details)
                }*/
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
}
