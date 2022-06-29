//
//  CoachsearchVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/19/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import SDWebImage

extension CoachSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return filterArray.count
        }else{
            return allUserListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return configureAllUserListTableCell(tableView, for: indexPath)
    }
    
    
    //MARK:-AllUserList
    private func configureAllUserListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllUserListTableViewCell") as? AllUserListTableViewCell else {
            fatalError("AllUserListTableViewCell not found")
        }
        if searching{
            cell.userNameLabel.text = filterArray[indexPath.row].name ?? ""
            cell.userDescriptionLabel.text = filterArray[indexPath.row].country?.name ?? ""
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string:filterArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.viewDetailsButton.tag = filterArray[indexPath.row].id ?? 0
            cell.sendFriendRequestButton.tag = filterArray[indexPath.row].id ?? 0
           // let rating = Double(filterArray[indexPath.row].averageRating ?? "0")
            //cell.ratingView.rating = rating ?? 0
            if filterArray[indexPath.row].isfriend == 0{
                cell.sendFriendRequestButton.isHidden = false
            }else{
                cell.sendFriendRequestButton.isHidden = true
            }
            if friendRequestSendArraylocal.contains(filterArray[indexPath.row].id ?? 0){
                cell.sendFriendRequestButton.isHidden = true
            }
        }else{
            cell.userNameLabel.text = allUserListArray[indexPath.row].name ?? ""
            cell.userDescriptionLabel.text = allUserListArray[indexPath.row].country?.name ?? ""
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string:allUserListArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.viewDetailsButton.tag = allUserListArray[indexPath.row].id ?? 0
            cell.sendFriendRequestButton.tag = allUserListArray[indexPath.row].id ?? 0
           // let rating = Double(userListData[indexPath.row].averageRating ?? "0")
           // cell.ratingView.rating = rating ?? 0
            
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
        //print("trainer id",sender.tag)
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
                        vc.comingFrom = "Coachfriend"
                    }
                }
            }
        
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
      
}

extension CoachSearchViewController: UITableViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let alluserListData = self.allUserListVM.allUserListResponse{
           let contentOffset = scrollView.contentOffset.y
           let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
           let threshold = Float(alluserListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && alluserListData.nextPageURL != nil{
                isLoadingMore = true
                allUserListService(currentPage: alluserListData.currentPage! + 1)
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
