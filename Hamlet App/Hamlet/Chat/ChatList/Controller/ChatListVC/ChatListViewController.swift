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

    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dueInLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var chatlistVM = ChatListViewModel()
    
    @IBOutlet weak var cardView: UIView!{
        didSet {
            cardView.setBorderWith(cornerRadius: 8.0, borderWidth: 0.0, borderColor: UIColor.white.cgColor, bound: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatListServiceService()
    }
    
    private func chatListServiceService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        chatlistVM.requestChatList{ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.chatlistVM.chatListResponse {
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

}
