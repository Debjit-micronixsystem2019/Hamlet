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

extension CommunitiesVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  guard let rows = communityWisePostListVM.postListData else { return 0 }
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
            cell.commentCountLabel.text =  "\(postArray[indexPath.row].commentsCount ?? 0)"
            cell.likeCountLabel.text =  "\(postArray[indexPath.row].likesCount ?? 0)"
            cell.postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.postImageView.sd_setImage(with: URL(string:postArray[indexPath.row].user?.profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.likeButton.tag = postArray[indexPath.row].id ?? 0
            cell.commentButton.tag = postArray[indexPath.row].id ?? 0
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
    
    @objc func likeButtonAction(sender:UIButton){
        postLikeService(postID:sender.tag)
    }
    
    @objc func commentButtonAction(sender:UIButton){
      // if let postList = self.communityWisePostListVM.postListData {
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
       // }
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

extension CommunitiesVC: UITableViewDelegate {
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
