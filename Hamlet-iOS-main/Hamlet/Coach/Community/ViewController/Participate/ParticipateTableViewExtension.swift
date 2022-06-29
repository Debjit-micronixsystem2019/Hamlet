//
//  ParticipateTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 5/20/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension ParticipateViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return configurePostTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    private func configurePostTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else {
            fatalError("PostTableViewCell not found")
        }
        cell.selectionStyle = .none
            cell.titleLabel.text = postArray[indexPath.row].title
            cell.descriptionLabel.text = postArray[indexPath.row].body
            cell.dateLabel.text =  postArray[indexPath.row].createdAt?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
            cell.postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.postImageView.sd_setImage(with: URL(string:postArray[indexPath.row].user?.profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
        
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
        if let postListData = self.communityWisePostListVM.postListData{
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
            let threshold = Float(postListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && postListData.nextPageURL != nil{
                isLoadingMore = true
                postListServiceCommunityWise(communityID:commynityData?.id ?? 0, currentPage: postListData.currentPage! + 1)

            }
        }
    }
}

extension ParticipateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func transelectCell(index : Int){
        let indexPath = IndexPath(item: index, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
