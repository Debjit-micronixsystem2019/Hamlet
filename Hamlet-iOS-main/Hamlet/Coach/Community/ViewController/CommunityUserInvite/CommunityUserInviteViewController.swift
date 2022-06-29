//
//  CommunityUserInviteViewController.swift
//  Hamlet
//
//  Created by admin on 6/22/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class CommunityUserInviteViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var invitesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - IBAction
    @IBAction func invitesButtonAction (_ sender : UIButton) {
        if selectArray == []{
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "Please select any user.", controller: self, completion: nil)
        }else{
            addUserInCommunity(UserID : selectArray, CommuntiyID: communityID)
        }
    }
    
    // MARK: - Variables
    var selectArray = [Int]()
    var allUserListVM = AllUserListViewModel()
    var addUserCommunityVM = AddUserCommunityViewModel()
    let refreshControl = UIRefreshControl()
    var allUserListArray = [AllUserListData]()
    var isLoadingMore = false
    
    var communityName = ""
    var communityID = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        invitesButton.layer.cornerRadius = 20
        isLoadingMore = false
        allUserListService(currentpage: 0)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        titleLabel.text = "Invite users from \(communityName) community."
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        isLoadingMore = false
        allUserListService(currentpage: 0)
        refreshControl.endRefreshing()
    }
    
    // MARK: - Data Received From VM
     func allUserListService(currentpage : Int) {
         DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        allUserListVM.requestAllUserList(with: 2, currentpage: currentpage){ [weak self] (result) in
             switch result {
             case .success:
                 if let details = self?.allUserListVM.allUserListResponse {
                    if self!.isLoadingMore{
                         self?.allUserListArray += details.data ?? []
                     }else{
                         self?.allUserListArray = details.data ?? []
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
        
    
    func addUserInCommunity(UserID : Array<Int>, CommuntiyID: Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        addUserCommunityVM.requestForAddUserInCommunity(with: UserID, communityID: CommuntiyID){ [weak self] (result) in
            switch result {
            case .success:
              //  if let details = self?.allUserListVM.allUserListResponse {
                    self?.addUserInCommunitiesSucessAlert()
             //   }
                self?.tableView.reloadData()
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
    
    func addUserInCommunitiesSucessAlert() {
           let alertController = UIAlertController(title: "Successfully!", message: "Users added successfully!", preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
               self.navigationController?.popViewController(animated: true)
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }

    
}


