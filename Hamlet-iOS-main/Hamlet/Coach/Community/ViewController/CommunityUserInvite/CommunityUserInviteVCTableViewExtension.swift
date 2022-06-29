//
//  CreateCommunityVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 5/20/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension CommunityUserInviteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // guard let rows = self.allUserListVM.allUserListResponse?.data else { return 0 }
        return allUserListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureSelectUserTableCell(tableView, for: indexPath)
    }
    
    private func configureSelectUserTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatUserListTableViewCell") as? GroupChatUserListTableViewCell else {
            fatalError("GroupChatUserListTableViewCell not found")
        }
      //  if let userListData = self.allUserListVM.allUserListResponse?.data {
            cell.userNameLabel.text = allUserListArray[indexPath.row].name ?? ""
            cell.countryname.text = allUserListArray[indexPath.row].country?.name
            cell.userImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.userImage.sd_setImage(with: URL(string:allUserListArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            
            cell.selectUnselectButton.tag = allUserListArray[indexPath.row].id ?? 0
            if selectArray.contains(allUserListArray[indexPath.row].id ?? 0){
                cell.selectUnselectButton.setImage(UIImage(named: "select-problem"), for: .normal)
            }else{
                cell.selectUnselectButton.setImage(UIImage(named: "Unselect"), for: .normal)
            }
       // }
        cell.selectUnselectButton.addTarget(self, action: #selector(selectunselectButtonAction), for: .touchUpInside)
        
        return cell
    }
    
    @objc func selectunselectButtonAction(sender:UIButton){
        if selectArray.contains(sender.tag){
            for (i,item) in selectArray.enumerated(){
                if sender.tag == item{
                    selectArray.remove(at: i)
                }
            }
        }else{
            selectArray.append(sender.tag)
        }
        print(selectArray)
        tableView.reloadData()
    }
}
extension CommunityUserInviteViewController: UITableViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let alluserListData = self.allUserListVM.allUserListResponse{
            let contentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
            let threshold = Float(alluserListData.total ?? 0)
    
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && alluserListData.nextPageURL != nil{
                isLoadingMore = true
                allUserListService(currentpage: alluserListData.currentPage! + 1)
            }
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
