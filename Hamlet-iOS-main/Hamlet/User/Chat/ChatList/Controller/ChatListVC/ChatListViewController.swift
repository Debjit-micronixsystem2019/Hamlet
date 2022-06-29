//
//  ChatListViewController.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import MBProgressHUD

class ChatListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var chatlistVM = ChatListViewModel()
    let refreshControl = UIRefreshControl()
    var chatListData = [ChatListData]()
    var isLoadingMore = false
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        isLoadingMore = false
        chatListServiceService(currentPage: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if screenHeight < 700 {
            topConstraint.constant = 30
        }
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        isLoadingMore = false
        chatListServiceService(currentPage: 1)
        refreshControl.endRefreshing()
    }
    
     func chatListServiceService(currentPage : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        chatlistVM.requestChatList(currentpage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.chatlistVM.chatListResponse?.data {
                    if self!.isLoadingMore{
                        self?.chatListData += details
                    }else{
                        self?.chatListData = details
                    }
                }
                self?.tableView.reloadData()
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
}
