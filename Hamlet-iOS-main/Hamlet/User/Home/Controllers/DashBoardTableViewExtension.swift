//
//  DashBoardTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import MBProgressHUD

extension DashBoardVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
           return communityArray.count
        } else if segmentedControl.selectedSegmentIndex == 1 {
            return postArray.count
        } else {
            guard let rows = bookingListVM.myBookingListResponse?.data else { return 0 }
            return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            return configureCommunityListTableCell(tableView, for: indexPath)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            return configurePostTableCell(tableView, for: indexPath)
        } else {
            return configureBookingListTableCell(tableView, for: indexPath)
        }
        
    }
    
    // MARK:- Configures Post Table Cell
    private func configurePostTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else {
            fatalError("PostTableViewCell not found")
        }
        cell.selectionStyle = .none
            cell.titleLabel.text = postArray[indexPath.row].title
            cell.descriptionLabel.text = postArray[indexPath.row].body
            cell.dateLabel.text =  postArray[indexPath.row].createdAt?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
            cell.commentCountLabel.text =  "\(postArray[indexPath.row].commentsCount ?? 0)"
            cell.likeCountLabel.text =  "\(postArray[indexPath.row].likesCount ?? 0)"
            cell.postImageView.sd_setImage(with: URL(string:postArray[indexPath.row].user?.profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.likeButton.tag = postArray[indexPath.row].id ?? 0
            cell.commentButton.tag = postArray[indexPath.row].id ?? 0
            cell.shareButton.tag = postArray[indexPath.row].id ?? 0
        cell.shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        cell.likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        
        if likeArrayLocalCount.contains(postArray[indexPath.row].id ?? 0){
            cell.likeCountLabel.text = "\(postArray[indexPath.row].likesCount! + 1)"
        }
        
        for (_,item) in commentArrayLocalCount.enumerated(){
            if item.id == postArray[indexPath.row].id{
                cell.commentCountLabel.text = "\(item.totalComment)"
            }
        }
        
        if translateArray.contains(postArray[indexPath.row].id ?? 0){
            cell.postBackgroundView.backgroundColor = UIColor.lightText
                //.withAlphaComponent(0.5)
            if let details = self.postTranslateVM.postTranslateResponce {
                cell.titleLabel.text = details.data
            }
        }else{
            cell.postBackgroundView.backgroundColor = UIColor.white
        }

        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if segmentedControl.selectedSegmentIndex == 1{
        if let postListData = self.postListVM.postListData{
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
            let threshold = Float(postListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && postListData.nextPageURL != nil{
                isLoadingMore = true
                postListService(currentPage : postListData.currentPage! + 1)
            }
        }
        }else if segmentedControl.selectedSegmentIndex == 0{
            
          if let communityListData = self.communityListVM.communityDetails{
            let contentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
                let threshold = Float(communityListData.total ?? 0)
            
                if (maximumOffset - contentOffset <= CGFloat(threshold)) && communityListData.nextPageURL != nil{
                    isLoadingMore = true
                    communityListService(page: communityListData.currentPage! + 1)
                }
            }
        }
    }
    
    
    @objc func shareButtonAction(sender:UIButton){
       // if let postList = self.postListVM.postListData {
            for (_,item) in postArray.enumerated(){
                if sender.tag == item.id{
                    sharePost(post : item.title, description : item.body)
                    break
                }
            }
       // }
    }
    
    @objc func likeButtonAction(sender:UIButton){
        postLikeService(postID:sender.tag)
    }
    
    @objc func commentButtonAction(sender:UIButton){
       // if let postList = self.postListVM.postListData {
            for (_,item) in postArray.enumerated(){
                if sender.tag == item.id{
                    
                    let mainStoryBoard = UIStoryboard(name: "Posts", bundle: nil)
                    let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CommentOnPostVC") as! CommentOnPostVC
                    vc.postData = item
                    vc.commentStatus = { (status) in
                        if status{
                            vc.totalComment = { (total) in
                                print("totalComment",total)
                                self.commentArrayLocalCount.append(CommentLocalCount(id: sender.tag, totalComment: total))
                                self.tableView.reloadData()
                            }
                        }
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    break
                }
            }
        //}
    }
    
    // MARK:- Configures Community Table Cell
    private func configureCommunityListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as? CommunityTableViewCell else {
            fatalError("CommunityTableViewCell not found")
        }
        cell.selectionStyle = .none
        cell.viewDetailsAction {
            print("clicked")
            let mainStoryBoard = UIStoryboard(name: "Communities", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CommunitiesVC") as! CommunitiesVC
          //  if let communityList = self.communityListVM.communityDetails?.data {
            vc.commynityData = self.communityArray[indexPath.row]
           // }
            self.navigationController?.pushViewController(vc, animated: true)
        }
       // if let communityList = self.communityListVM.communityDetails?.data {
            cell.communityName.text = communityArray[indexPath.row].name
            cell.communityDescription.text = communityArray[indexPath.row].dataDescription
            cell.communityMemberCount.text = "\(communityArray[indexPath.row].communityMembersCount ?? 0)"
            cell.communityImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.communityImage.sd_setImage(with: URL(string:communityArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.leaveButton.tag = communityArray[indexPath.row].id ?? 0
       // }
        cell.leaveButton.addTarget(self, action: #selector(communityLeaveButtonAction), for: .touchUpInside)
        
        return cell
    }
    
    // MARK:- Configures Booking Table Cell
    private func configureBookingListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell") as? BookingTableViewCell else {
            fatalError("BookingTableViewCell not found")
        }
        cell.selectionStyle = .none
        cell.viewDetailsAction {
            print("clicked")
            let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
            //vc.from = "user"
            vc.comingFrom = "friend"
            if let bookingList = self.bookingListVM.myBookingListResponse?.data {
                vc.userID = bookingList[indexPath.row].trainer?.id ?? 0
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if let bookingList = bookingListVM.myBookingListResponse?.data {
            cell.trainerName.text = bookingList[indexPath.row].trainer?.name
            cell.meetingDescription.text = bookingList[indexPath.row].bookingAt
            //UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
            cell.trainerImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.trainerImage.sd_setImage(with: URL(string:bookingList[indexPath.row].trainer?.image ?? ""), placeholderImage: UIImage(named: "noImage"))
            let rating = Double(bookingList[indexPath.row].trainer?.averageRating ?? "0")
            cell.ratingView.rating = rating ?? 0
        }
        cell.callButton.addTarget(self, action: #selector(callJoinButtonAction), for: .touchUpInside)
        
        return cell
    }
    
    @objc func communityLeaveButtonAction(sender:UIButton){
            for (_,item) in communityArray.enumerated(){
                if sender.tag == item.id{
                    showCommunityLeaveAlert(id:sender.tag, communityName : item.name ?? "")
                    break
            }
        }
    }
    
    @objc func callJoinButtonAction(sender: UIButton) {
        if let bookingList = bookingListVM.myBookingListResponse?.data {
            if bookingList[sender.tag].meetings?.first?.joinURL != nil {
                self.connectZoomMethod(with: bookingList[sender.tag].meetings?.first?.joinURL ?? "")
            } else {
                DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
                bookingListVM.requestZoomUrl(with: bookingList[sender.tag].trainer?.name ?? "", userId: bookingList[sender.tag].userID ?? 0, bookigId: bookingList[sender.tag].id ?? 0) { [weak self] (result) in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                        self?.bookingListService()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self?.connectZoomMethod(with: bookingList[sender.tag].meetings?.first?.joinURL ?? "")
                        }
                    case .failure(let error):
                        print(error.description)
                        HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                        DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
                    }
                }
            }
        }
    }
    
    func connectZoomMethod(with url: String) {
        guard let url = URL(string: url) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

extension DashBoardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 1 {
            if translateArray.contains(postArray[indexPath.row].id ?? 0){
                translateArray.removeAll()
            }else{
                let id = postArray[indexPath.row].id ?? 0
                translateArray.removeAll()
                translateArray.append(id)
                posTranslateService(postID: postArray[indexPath.row].id ?? 0, translateID: AppSettings.shared.userChatLanguageId, index :indexPath.row)
            }
        tableView.reloadData()
        }
    }
    
    func transelectCell(index : Int){
        let indexPath = IndexPath(item: index, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
