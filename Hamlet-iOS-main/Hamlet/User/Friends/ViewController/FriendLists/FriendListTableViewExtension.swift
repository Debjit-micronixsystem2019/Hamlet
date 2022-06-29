//
//  FriendListTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import SDWebImage

extension FriendListsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            if usersearching{
                return userFilterArray.count
            }else{
             return allUserListArray.count
            }
        }else if segmentedControl.selectedSegmentIndex == 1 {
            if myFriendsearching{
                return myFriendFilterArray.count
            }else{
            // guard let rows = self.allFriendsListVM.allFriendsListResponse?.data else { return 0 }
             return myFriendListArray.count
            }
        }else {
            guard let rows = self.friendsRequestListVM.friendsRequestListResponse?.data else { return 0 }
             return rows.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return configureAllUserListTableCell(tableView, for: indexPath)
        }else if segmentedControl.selectedSegmentIndex == 1 {
            return configureAllFriendsListTableCell(tableView, for: indexPath)
        }else{
            return configureAllFriendRequestesListTableCell(tableView, for: indexPath)
        }
    }
    
    //MARK:-AllFriendRequestesList
    private func configureAllFriendRequestesListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendRequestTableViewCell") as? FriendRequestTableViewCell else {
            fatalError("FriendRequestTableViewCell not found")
        }
        if let friendRequestListData = self.friendsRequestListVM.friendsRequestListResponse?.data {
            if friendRequestListData[indexPath.row].isPrivate == 0{
                cell.ratingView.isHidden = true
                cell.userNameLabel.text = friendRequestListData[indexPath.row].chatName ?? ""
                cell.userDescriptionLabel.text = "\(friendRequestListData[indexPath.row].senderName ?? "") has sent a group chat request."
                cell.userIdentityLabel.text = "Group"
            }else{
                cell.ratingView.isHidden = false
                cell.userNameLabel.text = friendRequestListData[indexPath.row].senderName ?? ""
                cell.userDescriptionLabel.text = "\(friendRequestListData[indexPath.row].senderName ?? "") sent you a friend request."
               /* let rating = Double(friendRequestListData[indexPath.row].user?.averageRating ?? "0")
                cell.ratingView.rating = rating ?? 0*/
                cell.userIdentityLabel.text = "Private"
            }
            
            
        cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.userImageView.sd_setImage(with: URL(string: friendRequestListData[indexPath.row].senderImage ?? ""), placeholderImage: UIImage(named: "noImage"))
        cell.viewDetailsButton.tag = friendRequestListData[indexPath.row].senderID ?? 0
        cell.acceptButton.tag = friendRequestListData[indexPath.row].chatID ?? 0
        cell.rejectButton.tag = friendRequestListData[indexPath.row].chatID ?? 0
            
        }
        cell.viewDetailsButton.addTarget(self, action: #selector(FriendRequestUserviewDetailsButtonAction), for: .touchUpInside)
        cell.acceptButton.addTarget(self, action: #selector(FriendRequestAcceptButtonAction), for: .touchUpInside)
        cell.rejectButton.addTarget(self, action: #selector(FriendRequestRejectButtonAction), for: .touchUpInside)

        return cell
    }
    
    @objc func FriendRequestRejectButtonAction(sender:UIButton){
        if let data = self.friendsRequestListVM.friendsRequestListResponse?.data {
            for (_,item) in data.enumerated(){
                if sender.tag == item.chatID{
                    if item.isPrivate == 1{
                    showFriendRequestAcceptRejectConfirmationAlert(id:item.id ?? 0,accept : false, message : "Do you want to reject \(item.senderName!) friend request?")
                    }else{
                        showGroupChatRequestAcceptRejectConfirmationAlert(id:item.chatID ?? 0,accept : false, message : "Do you want to reject \(item.chatName!) group chat request?")
                    }
                }
            }
        }
    }
    
    @objc func FriendRequestAcceptButtonAction(sender:UIButton){
        if let data = self.friendsRequestListVM.friendsRequestListResponse?.data {
            for (_,item) in data.enumerated(){
                if sender.tag == item.chatID{
                    if item.isPrivate == 1{
                    showFriendRequestAcceptRejectConfirmationAlert(id:item.id ?? 0,accept : true, message : "Do you want to accept \(item.senderName!) friend request?")
                    }else{
                       showGroupChatRequestAcceptRejectConfirmationAlert(id:item.chatID ?? 0,accept : true, message : "Do you want to accept \(item.chatName!) group chat request?")
                    }
                }
            }
        }
    }
    
    @objc func FriendRequestUserviewDetailsButtonAction(sender:UIButton){
        let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
        if let data = self.friendsRequestListVM.friendsRequestListResponse?.data {
            for (_,item) in data.enumerated(){
                if sender.tag == item.senderID{
                    vc.userID = item.senderID ?? 0
                }
            }
        }
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK:-AllUserList
    private func configureAllUserListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllUserListTableViewCell") as? AllUserListTableViewCell else {
            fatalError("AllUserListTableViewCell not found")
        }
        
        if usersearching{
            cell.userNameLabel.text = userFilterArray[indexPath.row].name ?? ""
            cell.userDescriptionLabel.text = userFilterArray[indexPath.row].country?.name ?? ""
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string:userFilterArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.viewDetailsButton.tag = userFilterArray[indexPath.row].id ?? 0
            cell.sendFriendRequestButton.tag = userFilterArray[indexPath.row].id ?? 0
            
            if userFilterArray[indexPath.row].userTypeID == 2{
                cell.ratingView.isHidden = true
                cell.bottomConstant.constant = 50
                cell.userIdentityLabel.text = "User"
                cell.userImageView.layer.cornerRadius = 25
            }else{
                cell.ratingView.isHidden = false
                let rating = Double(userFilterArray[indexPath.row].averageRating ?? "0")
                 cell.ratingView.rating = rating ?? 0
                cell.bottomConstant.constant = 74
                cell.userIdentityLabel.text = "Cometrad"
                cell.userImageView.layer.cornerRadius = 2
            }
            
            if userFilterArray[indexPath.row].isfriend == 0{
                cell.sendFriendRequestButton.isHidden = false
            }else{
                cell.sendFriendRequestButton.isHidden = true
            }
            
            if friendRequestSendArraylocal.contains(userFilterArray[indexPath.row].id ?? 0){
                cell.sendFriendRequestButton.isHidden = true
            }
            
            
        }else{
            cell.userNameLabel.text = allUserListArray[indexPath.row].name ?? ""
            cell.userDescriptionLabel.text = allUserListArray[indexPath.row].country?.name ?? ""
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string:allUserListArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.viewDetailsButton.tag = allUserListArray[indexPath.row].id ?? 0
            cell.sendFriendRequestButton.tag = allUserListArray[indexPath.row].id ?? 0
            //User Rating view hide
            if allUserListArray[indexPath.row].userTypeID == 2{
                cell.ratingView.isHidden = true
                cell.bottomConstant.constant = 50
                cell.userIdentityLabel.text = "User"
                cell.userImageView.layer.cornerRadius = 25

            }else{
                cell.ratingView.isHidden = false
                let rating = Double(allUserListArray[indexPath.row].averageRating ?? "0")
                cell.ratingView.rating = rating ?? 0
                cell.bottomConstant.constant = 74
                cell.userIdentityLabel.text = "Cometrad"
                cell.userImageView.layer.cornerRadius = 2

            }
            
            if allUserListArray[indexPath.row].isfriend == 0{
                cell.sendFriendRequestButton.isHidden = false
            }else{
                cell.sendFriendRequestButton.isHidden = true
            }
            
            if friendRequestSendArraylocal.contains(allUserListArray[indexPath.row].id ?? 0){
                cell.sendFriendRequestButton.isHidden = true
            }
        }
        cell.viewDetailsButton.addTarget(self, action: #selector(UserviewDetailsButtonAction), for: .touchUpInside)
        cell.sendFriendRequestButton.addTarget(self, action: #selector(sendFriendRequestButtonAction), for: .touchUpInside)

        return cell
    }
    
    @objc func sendFriendRequestButtonAction(sender:UIButton){
            for (_,item) in allUserListArray.enumerated(){
                if sender.tag == item.id{
                    showFriendRequestConfirmationAlert(id:sender.tag, senderName: item.name ?? "")
                    break
                }
            }
    }
    
    @objc func UserviewDetailsButtonAction(sender:UIButton){
        let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
            for (_,item) in allUserListArray.enumerated(){
                if sender.tag == item.id{
                    vc.userID = item.id ?? 0
                    if item.isfriend != 0{
                    vc.comingFrom = "friend"
                    }
                }
            }
        
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK:-AllFriendsList
    private func configureAllFriendsListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsListTableViewCell") as? AllFriendsListTableViewCell else {
            fatalError("AllFriendsListTableViewCell not found")
        }
        
        if myFriendsearching{
            cell.userNameLabel.text = myFriendFilterArray[indexPath.row].name ?? ""
            cell.userDescriptionLabel.text = ""
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string:myFriendFilterArray[indexPath.row].profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.viewDetailsButton.tag = myFriendFilterArray[indexPath.row].id ?? 0
            
            if myFriendFilterArray[indexPath.row].userTypeID == 2{
                cell.ratingView.isHidden = true
                cell.bottomConstant.constant = 55
                cell.userIdentityLabel.text = "User"
                cell.userImageView.layer.cornerRadius = 25
            }else{
                cell.ratingView.isHidden = false
                let rating = Double(myFriendFilterArray[indexPath.row].averagerating ?? "0")
                cell.ratingView.rating = rating ?? 0
                cell.bottomConstant.constant = 74
                cell.userIdentityLabel.text = "Cometrad"
                cell.userImageView.layer.cornerRadius = 2
            }

            
    }else{
        if myFriendListArray.count > 0 {
            cell.userNameLabel.text = myFriendListArray[indexPath.row].name ?? ""
            cell.userDescriptionLabel.text = ""
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string:myFriendListArray[indexPath.row].profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.viewDetailsButton.tag = myFriendListArray[indexPath.row].id ?? 0
            if myFriendListArray[indexPath.row].userTypeID == 2{
                cell.ratingView.isHidden = true
                cell.bottomConstant.constant = 55
                cell.userIdentityLabel.text = "User"
                cell.userImageView.layer.cornerRadius = 25
            }else{
                cell.ratingView.isHidden = false
                let rating = Double(myFriendListArray[indexPath.row].averagerating ?? "0")
                cell.ratingView.rating = rating ?? 0
                cell.bottomConstant.constant = 74
                cell.userIdentityLabel.text = "Cometrad"
                cell.userImageView.layer.cornerRadius = 2
            }

        }
    }
        cell.viewDetailsButton.addTarget(self, action: #selector(FriendsviewDetailsButtonAction), for: .touchUpInside)

        return cell
    }
    
    @objc func FriendsviewDetailsButtonAction(sender:UIButton){
        let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
        vc.comingFrom = "friend"
        //if let data = self.allFriendsListVM.allFriendsListResponse?.data {
            for (_,item) in myFriendListArray.enumerated(){
                if sender.tag == item.id{
                    vc.userID = item.id ?? 0
                }
            }
        //}
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
}

extension FriendListsVC: UITableViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if segmentedControl.selectedSegmentIndex == 0{
        if let alluserListData = self.allUserListVM.allUserListResponse{
           let contentOffset = scrollView.contentOffset.y
           let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
           let threshold = Float(alluserListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && alluserListData.nextPageURL != nil{
                isLoadingMore = true
                allUserListService(currentPage: alluserListData.currentPage! + 1)
            }
        }
      }else if segmentedControl.selectedSegmentIndex == 1{
        if let allFriendsListData = self.allFriendsListVM.allFriendsListResponse{
           let contentOffset = scrollView.contentOffset.y
           let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
           let threshold = Float(allFriendsListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && allFriendsListData.nextPageURL != nil{
                isLoadingMore = true
                allFriendsListService(currentPage: allFriendsListData.currentPage! + 1)
            }
        }
      }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* if let problemListData = self.selectProblemListVM.selectProblemResponse?.data {
            selectProblemID?(problemListData[indexPath.row].id ?? 0,problemListData[indexPath.row].name ?? "0")
            self.dismiss(animated: true, completion: nil)
        }*/
    }
}
