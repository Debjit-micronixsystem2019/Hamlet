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

extension CommentOnPostVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // guard let rows = self.commentListVM.commentListData?.data else { return 0 }
        return commentListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return configureCommentListTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    private func configureCommentListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentOnPostTableViewCell") as? CommentOnPostTableViewCell else {
            fatalError("CommentOnPostTableViewCell not found")
        }
        cell.selectionStyle = .none
        
       // if let commentList = self.commentListVM.commentListData?.data {
            cell.userNameLabel.text = commentListArray[indexPath.row].user?.name ?? ""
            cell.commentLabel.text = commentListArray[indexPath.row].comment ?? ""
            cell.dateLabel.text = commentListArray[indexPath.row].createdAt?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
            cell.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImageView.sd_setImage(with: URL(string:commentListArray[indexPath.row].user?.profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
       // }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CommentOnPostVC: UITableViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let commentList = self.commentListVM.commentListData{
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        let threshold = Float(commentList.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && commentList.nextPageURL != nil{
                isLoadingMore = true
                commentListService(postID:postData?.id ?? 0, currentPage: commentList.currentPage! + 1)

            }
        }
     }
}
