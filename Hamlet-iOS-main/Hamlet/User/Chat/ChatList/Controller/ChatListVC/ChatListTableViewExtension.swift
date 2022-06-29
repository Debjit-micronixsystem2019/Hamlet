//
//  ChatTableViewExtension.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import SDWebImage

extension ChatListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureRentTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    private func configureRentTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ChatListCell else {
            fatalError("ChatViewCell not found")
        }
        cell.selectionStyle = .none
        cell.nameLabel.text = chatListData[indexPath.row].name ?? ""
        cell.lastMessageLabel.text = chatListData[indexPath.row].latestMessage?.message ?? ""
        cell.lastMessageDateLabel.text = chatListData[indexPath.row].latestMessage?.createdAt?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
        cell.profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.profileImageView.sd_setImage(with: URL(string: chatListData[indexPath.row].latestMessage?.sender?.profilePicture ?? "" ), placeholderImage: UIImage(named: "noImage"))
        return cell
    }
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let chatListData = self.chatlistVM.chatListResponse{
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        let threshold = Float(chatListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && chatListData.nextPageURL != nil{
           // if let currentPage = self.chatlistVM.chatListResponse?.currentPage {
            isLoadingMore = true
            chatListServiceService(currentPage: chatListData.currentPage! + 1)
            }
        }
    }
    
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Chat", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(identifier: "ChatVC") as! ChatVC
            vc.friendID  = chatListData[indexPath.row].id ?? 0
        print(chatListData[indexPath.row].id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

