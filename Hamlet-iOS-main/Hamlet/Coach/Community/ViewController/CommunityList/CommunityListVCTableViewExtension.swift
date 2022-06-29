//
//  CommunityListVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 5/20/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import MBProgressHUD

extension CommunityListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCommunityListTableCell(tableView, for: indexPath)
    }
    
    // MARK:- Configures Post Table Cell

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let communityListData = self.communityListVM.communityDetails{
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
            let threshold = Float(communityListData.total ?? 0)
        
            if (maximumOffset - contentOffset <= CGFloat(threshold)) && communityListData.nextPageURL != nil{
                isLoadingMore = true
                communityListService(currentPage: communityListData.currentPage! + 1)
            }
        }
    }
        
    // MARK:- Configures Community Table Cell
    private func configureCommunityListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCommunityListTableViewCell") as? CreateCommunityListTableViewCell else {
            fatalError("CreateCommunityListTableViewCell not found")
        }
        cell.selectionStyle = .none
        cell.viewDetailsAction {
            print("clicked")
            let mainStoryBoard = UIStoryboard(name: "CreateCommunity", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ParticipateViewController") as! ParticipateViewController
           // if let communityList = self.communityListVM.communityDetails?.data {
            vc.commynityData = self.communityArray[indexPath.row]
           // }
            self.navigationController?.pushViewController(vc, animated: true)
        }
            cell.communityName.text = communityArray[indexPath.row].name
            cell.communityDescription.text = communityArray[indexPath.row].dataDescription
            cell.communityMemberCount.text = "\(communityArray[indexPath.row].communityMembersCount ?? 0)"
            cell.communityImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.communityImage.sd_setImage(with: URL(string:communityArray[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.inviteButton.tag = communityArray[indexPath.row].id ?? 0
        cell.inviteButton.addTarget(self, action: #selector(communityInviteButtonAction), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func communityInviteButtonAction(sender:UIButton){
        if let communityList = self.communityListVM.communityDetails?.data {
            for (_,item) in communityList.enumerated(){
                if sender.tag == item.id{
                    let mainStoryBoard = UIStoryboard(name: "CreateCommunity", bundle: nil)
                    let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CommunityUserInviteViewController") as! CommunityUserInviteViewController
                    vc.communityName = item.name ?? ""
                    vc.communityID = item.id ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                }
            }
        }
    }
}

extension CommunityListViewController: UITableViewDelegate {
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 150
    //    }
}
