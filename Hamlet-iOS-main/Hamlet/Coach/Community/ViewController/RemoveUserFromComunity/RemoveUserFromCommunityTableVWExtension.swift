//
//  RemoveUserFromCommunityTableVWExtension.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension RemoveUserFromCommunityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = participantsUserListInCommunityVM.participantUserInCommunity else { return 0 }
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureGroupUserListTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    private func configureGroupUserListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupUserListCell") as? groupUserListCell else {
            fatalError("groupUserListCell not found")
        }
        cell.selectionStyle = .none
        
        if let userList = self.participantsUserListInCommunityVM.participantUserInCommunity {
            cell.username.text = userList[indexPath.row].user?.name
            cell.profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.profileImageView.sd_setImage(with: URL(string: userList[indexPath.row].user?.profilePicture ?? "" ), placeholderImage: UIImage(named: "noImage"))
            cell.removeButton.tag = userList[indexPath.row].user?.id ?? 0
            cell.viewDetailsButton.tag = userList[indexPath.row].user?.id ?? 0
        }
        cell.viewDetailsButton.addTarget(self, action: #selector(userViewDetailsButtonAction), for: .touchUpInside)
        cell.removeButton.addTarget(self, action: #selector(userRemoveFromGroupButtonAction), for: .touchUpInside)
        return cell
    }
    
    
    @objc func userRemoveFromGroupButtonAction(sender:UIButton){
        if let data = self.participantsUserListInCommunityVM.participantUserInCommunity {
            for (_,item) in data.enumerated(){
                if sender.tag == item.user?.id{
                    removeUserFromCommunityConfirmationAlert(userid:item.user?.id ?? 0, message : "Do you want to remove \(item.user?.name ?? "") from \(community_name) Community?")
                }
            }
        }
    }
    
    @objc func userViewDetailsButtonAction(sender:UIButton){
        let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
        if let trainerList = self.participantsUserListInCommunityVM.participantUserInCommunity {
            for (_,item) in trainerList.enumerated(){
                if sender.tag == item.user?.id{
                    vc.userID = item.user?.id ?? 0
                   // if item.user.isRequestAccepted == 1{
                    vc.comingFrom = "friend"
                    //}
                }
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RemoveUserFromCommunityViewController: UITableViewDelegate {
}

