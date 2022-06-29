//
//  CoachChatListTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension CoachChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureRentTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    private func configureRentTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoachChatListTableViewCell") as? CoachChatListTableViewCell else {
            fatalError("ChatViewCell not found")
        }
        cell.selectionStyle = .none
        
       // if let ChatListData = self.chatlistVM.chatListResponse?.data {
            cell.nameLabel.text = chatListData[indexPath.row].name ?? ""
            cell.lastMessageLabel.text = chatListData[indexPath.row].latestMessage?.message ?? ""
            cell.lastMessageDateLabel.text = chatListData[indexPath.row].latestMessage?.createdAt?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
            cell.profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.profileImageView.sd_setImage(with: URL(string: chatListData[indexPath.row].latestMessage?.sender?.profilePicture ?? "" ), placeholderImage: UIImage(named: "noImage"))
        //}
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let chatListData = self.chatlistVM.chatListResponse{
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        let threshold = Float(chatListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && chatListData.nextPageURL != nil{
            isLoadingMore = true
            chatListServiceService(currentPage: chatListData.currentPage! + 1)
            }
        }
    }

}

extension CoachChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Chat", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(identifier: "ChatVC") as! ChatVC
       // if let ChatListData = self.chatlistVM.chatListResponse?.data {
            vc.friendID  = chatListData[indexPath.row].id ?? 0
            if chatListData[indexPath.row].isPrivate == 0{
                vc.comingFrom = "Group"
                vc.groupName = chatListData[indexPath.row].name ?? ""
            }
        //}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

