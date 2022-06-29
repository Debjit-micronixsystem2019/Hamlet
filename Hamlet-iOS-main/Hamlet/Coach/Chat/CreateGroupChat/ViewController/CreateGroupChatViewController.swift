//
//  CreateGroupChatViewController.swift
//  Hamlet
//
//  Created by admin on 11/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class CreateGroupChatViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var groupChatTextField: UITextField!
    @IBOutlet weak var invitesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBAction
    @IBAction func invitesButtonAction (_ sender : UIButton) {
        if selectArray == []{
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: Constants.noUserSelection, controller: self, completion: nil)
        }else if (groupChatTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "Please enter a group name.", controller: self, completion: nil)
        }else{
            createGroupChatService(userids : selectArray, groupName : groupChatTextField.text!)
        }
    }
    
    // MARK: - Variables
    var selectArray = [Int]()
    var allUserListVM = AllUserListViewModel()
    var createGroupChatVM = CreateGroupChatViewModel()
    let refreshControl = UIRefreshControl()
    var allUserListArray = [AllUserListData]()
    var isLoadingMore = false

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
    
    private func createGroupChatService(userids : Array<Int>, groupName : String) {
         DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        createGroupChatVM.requestCreateGroup(with: userids, groupName: groupName){ [weak self] (result) in
             switch result {
             case .success:
                self?.createGroupSucessAlert()
                /* if let details = self?.createGroupChatVM.allUserListResponse {
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
    
    func createGroupSucessAlert() {
           let alertController = UIAlertController(title: "Successfully!", message: "Group created successfully.", preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
               self.navigationController?.popViewController(animated: true)
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
}
