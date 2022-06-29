//
//  RemoveUserFromCommunityViewController.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class RemoveUserFromCommunityViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var participantsUserListInCommunityVM = ParticipantsUserListInCommunityViewModel()
    var userRemoveFromCommunityVM = UserRemoveFromCommunityViewModel()
    var community_id = Int()
    var community_name = String()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        self.title = "Participants"
        tableView.delegate = self
        tableView.dataSource = self
        communityUserListService(communityid: community_id)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        communityUserListService(communityid: community_id)
        refreshControl.endRefreshing()
    }
    
    // MARK: - Request Data To VM From UI
    private func communityUserListService(communityid : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        participantsUserListInCommunityVM.requestForParticipantUserListInCommunity(communityID: communityid){ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
              /*  if let details = self?.participantsUserListInCommunityVM.groupChatUserListResponse{
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
    
   private func userRemoveFromCommunityService(communityid : Int,userid : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        userRemoveFromCommunityVM.requestUserRemoveFromCommunity( with: communityid, userID: userid){ [weak self] (result) in
            switch result {
            case .success:
                self?.communityUserListService(communityid: self?.community_id ?? 0)
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
        
    func removeUserFromCommunityConfirmationAlert(userid:Int, message : String) {
        HTAlert.showAlertWithOptions(title: "Confirmation!", message: message, firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.userRemoveFromCommunityService(communityid: self.community_id, userid: userid)
            }
        }
    }
}
