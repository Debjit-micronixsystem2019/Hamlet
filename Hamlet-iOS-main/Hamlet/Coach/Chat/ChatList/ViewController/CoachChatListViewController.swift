//
//  CoachChatListViewController.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class CoachChatListViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    var chatlistVM = ChatListViewModel()
    let refreshControl = UIRefreshControl()
    var chatListData = [ChatListData]()
    var isLoadingMore = false
    
    // MARK: - IBActions
    @IBAction func groupChatButtonAction (_ sender : UIButton){
        
        let mainStoryBoard = UIStoryboard(name: "CoachChatList", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "CreateGroupChatViewController") as! CreateGroupChatViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isLoadingMore = false
        chatListServiceService(currentPage: 0)
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
        chatListServiceService(currentPage: 0)
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
                    self?.tableView.reloadData()
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
}
