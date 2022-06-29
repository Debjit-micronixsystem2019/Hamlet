//
//  GroupChatUserListTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 12/3/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension GroupChatUserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = groupChatUserListVM.groupChatUserListResponse?.data else { return 0 }
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
        
        if let userList = self.groupChatUserListVM.groupChatUserListResponse?.data {
            cell.username.text = userList[indexPath.row].name
            cell.profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.profileImageView.sd_setImage(with: URL(string: userList[indexPath.row].profilePicture ?? "" ), placeholderImage: UIImage(named: "noImage"))
            cell.removeButton.tag = userList[indexPath.row].id ?? 0
            cell.viewDetailsButton.tag = userList[indexPath.row].id ?? 0
        }
        cell.viewDetailsButton.addTarget(self, action: #selector(userViewDetailsButtonAction), for: .touchUpInside)
        cell.removeButton.addTarget(self, action: #selector(userRemoveFromGroupButtonAction), for: .touchUpInside)
        return cell
    }
    
    
    @objc func userRemoveFromGroupButtonAction(sender:UIButton){
        if let data = self.groupChatUserListVM.groupChatUserListResponse?.data {
            for (_,item) in data.enumerated(){
                if sender.tag == item.id{
                    removeUserFromGroupConfirmationAlert(userid:item.id ?? 0, message : "Do you want to remove \(item.name ?? "") from \(group_name) Group?")
                }
            }
        }
    }
    
    @objc func userViewDetailsButtonAction(sender:UIButton){
        let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
        if let trainerList = self.groupChatUserListVM.groupChatUserListResponse?.data {
            for (_,item) in trainerList.enumerated(){
                if sender.tag == item.id{
                    vc.userID = item.id ?? 0
                    if item.isRequestAccepted == 1{
                    vc.comingFrom = "friend"
                    }
                }
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GroupChatUserListViewController: UITableViewDelegate {
}

