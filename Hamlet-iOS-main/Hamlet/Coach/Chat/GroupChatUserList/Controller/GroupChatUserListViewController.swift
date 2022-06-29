//
//  GroupChatUserListViewController.swift
//  Hamlet
//
//  Created by admin on 12/3/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class GroupChatUserListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var groupChatUserListVM = GroupChatUserListViewModel()
    var userRemoveFromGroupVM = UserRemoveFromGroupViewModel()
    var group_id = Int()
    var group_name = String()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        self.title = "Participants"
        tableView.delegate = self
        tableView.dataSource = self
        groupUserListService(groupid: group_id)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        groupUserListService(groupid: group_id)
        refreshControl.endRefreshing()
    }
    
    // MARK: - Request Data To VM From UI
    private func groupUserListService(groupid : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        groupChatUserListVM.requestUserList( with: groupid){ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
              /*  if let details = self?.groupChatUserListVM.groupChatUserListResponse{
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
    
   private func userRemoveFromGroupService(groupid : Int,userid : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        userRemoveFromGroupVM.requestUserRemoveFromGroup( with: groupid, userID: userid){ [weak self] (result) in
            switch result {
            case .success:
                self?.groupUserListService(groupid: self?.group_id ?? 0)
              /*  if let details = self?.userRemoveFromGroupVM.groupChatUserListResponse{
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
        
    func removeUserFromGroupConfirmationAlert(userid:Int, message : String) {
        HTAlert.showAlertWithOptions(title: "Confirmation!", message: message, firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.userRemoveFromGroupService(groupid: self.group_id, userid: userid)
            }
        }
    }
}
