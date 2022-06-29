//
//  CoachFriendsVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/19/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import SDWebImage

extension CoachFriendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            if searching{
                return filterArray.count
            }else{
                return myFriendListArray.count
            }
        }else {
            guard let rows = self.friendsRequestListVM.friendsRequestListResponse?.data else { return 0 }
             return rows.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if segmentedControl.selectedSegmentIndex == 0 {
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
            cell.userNameLabel.text = friendRequestListData[indexPath.row].senderName ?? ""
            cell.userDescriptionLabel.text = "\(friendRequestListData[indexPath.row].senderName ?? "") sent you a friend request."
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string: friendRequestListData[indexPath.row].senderImage ?? ""), placeholderImage: UIImage(named: "noImage"))
            
        cell.viewDetailsButton.tag = friendRequestListData[indexPath.row].senderID ?? 0
        cell.acceptButton.tag = friendRequestListData[indexPath.row].senderID ?? 0
        cell.rejectButton.tag = friendRequestListData[indexPath.row].senderID ?? 0
           // let rating = Double(friendRequestListData[indexPath.row].user?.averageRating ?? "0")
          //  cell.ratingView.rating = rating ?? 0
            
        }
        cell.viewDetailsButton.addTarget(self, action: #selector(FriendRequestUserviewDetailsButtonAction), for: .touchUpInside)
        cell.acceptButton.addTarget(self, action: #selector(FriendRequestAcceptButtonAction), for: .touchUpInside)
        cell.rejectButton.addTarget(self, action: #selector(FriendRequestRejectButtonAction), for: .touchUpInside)

        return cell
    }
    
    @objc func FriendRequestRejectButtonAction(sender:UIButton){
        if let data = self.friendsRequestListVM.friendsRequestListResponse?.data {
            for (_,item) in data.enumerated(){
                if sender.tag == item.senderID{
                    showFriendRequestAcceptRejectConfirmationAlert(id:item.id ?? 0,accept : false, message : "Do you want to reject \(item.senderName!) friend request?")
                }
            }
        }
    }
    
    @objc func FriendRequestAcceptButtonAction(sender:UIButton){
        if let data = self.friendsRequestListVM.friendsRequestListResponse?.data {
            for (_,item) in data.enumerated(){
                if sender.tag == item.senderID{
                    showFriendRequestAcceptRejectConfirmationAlert(id:item.id ?? 0,accept : true, message : "Do you want to accept \(item.senderName!) friend request?")
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
    
    
    //MARK:-AllFriendsList
    private func configureAllFriendsListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllFriendsListTableViewCell") as? AllFriendsListTableViewCell else {
            fatalError("AllFriendsListTableViewCell not found")
        }
        
        if searching{
                cell.userNameLabel.text = filterArray[indexPath.row].name ?? ""
                cell.userDescriptionLabel.text = ""
                cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.userImageView.sd_setImage(with: URL(string:filterArray[indexPath.row].profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
                cell.viewDetailsButton.tag = filterArray[indexPath.row].id ?? 0
               // let rating = Double(filterArray[indexPath.row].averagerating ?? "0")
               // cell.ratingView.rating = rating ?? 0
        }else{
                cell.userNameLabel.text = myFriendListArray[indexPath.row].name ?? ""
                cell.userDescriptionLabel.text = ""
                cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.userImageView.sd_setImage(with: URL(string:myFriendListArray[indexPath.row].profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
                cell.viewDetailsButton.tag = myFriendListArray[indexPath.row].id ?? 0
                //let rating = Double(allFriendsListData[indexPath.row].averagerating ?? "0")
               // cell.ratingView.rating = rating ?? 0
            
        }
        cell.viewDetailsButton.addTarget(self, action: #selector(FriendsviewDetailsButtonAction), for: .touchUpInside)

        return cell
    }
    
    @objc func FriendsviewDetailsButtonAction(sender:UIButton){
        let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
        vc.comingFrom = "Coachfriend"
            for (_,item) in myFriendListArray.enumerated(){
                if sender.tag == item.id{
                    vc.userID = item.id ?? 0
                }
            }
        
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
}

extension CoachFriendViewController: UITableViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if segmentedControl.selectedSegmentIndex == 0{
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
