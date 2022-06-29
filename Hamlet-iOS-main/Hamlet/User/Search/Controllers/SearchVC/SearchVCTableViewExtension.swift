//
//  SearchVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension SearchVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = Int()
        switch section {
        case 0:
           guard let trainerrows = trainerCommunityListVM.TrainerCommunityListData?.communities else { return 0 }
           numberOfRows = trainerrows.count
        case 1:
            if searching{
               numberOfRows = filterArray.count
            }else{
          guard let communityrows = trainerCommunityListVM.TrainerCommunityListData?.trainers else { return 0 }
          numberOfRows = communityrows.count
            }
        default:
            break
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = UITableViewCell()
            switch indexPath.section {
            case 0:
                cell = configureCommunityListTableCell(tableView, for: indexPath)
            case 1:
                cell = configureTrainerListTableCell(tableView, for: indexPath)
            default:
                break
            }
        return cell
    }
    
    // Configures Table Cell
    private func configureTrainerListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerListTableViewCell") as? TrainerListTableViewCell else {
            fatalError("TrainerListTableViewCell not found")
        }
        cell.selectionStyle = .none
        
        if searching {
            cell.trainerNameLabel.text = filterArray[indexPath.row].name
            cell.trainerDescriptionLabel.text = "Cometrad"
            cell.trainerImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.trainerImageView.sd_setImage(with: URL(string:filterArray[indexPath.row].profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
            if let expertise = filterArray[indexPath.row].experties{
                let expertiseName = expertise.map {($0.name) ?? nil}.compactMap({$0}).joined(separator: ", ")
                if expertiseName != ""{
                    cell.expertiseInLabel.text = "Expertise in:- \(expertiseName)"
                }else{
                    cell.expertiseInLabel.text = ""
                }
            }
            
            cell.bookButton.tag = filterArray[indexPath.row].id ?? 0
            cell.viewDetailsButton.tag = filterArray[indexPath.row].id ?? 0
            cell.sendFriendRequestButton.tag = filterArray[indexPath.row].id ?? 0
            let rating = Double(filterArray[indexPath.row].averageRating ?? "0")
            cell.ratingView.rating = rating ?? 0
            if filterArray[indexPath.row].isfriend == 0{
                cell.sendFriendRequestButton.isHidden = false
            }else{
                cell.sendFriendRequestButton.isHidden = true
            }

            
        }else{

        if let trainerList = self.trainerCommunityListVM.TrainerCommunityListData?.trainers {
            cell.trainerNameLabel.text = trainerList[indexPath.row].name
            cell.trainerDescriptionLabel.text = "Cometrad"
            cell.trainerImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.trainerImageView.sd_setImage(with: URL(string:trainerList[indexPath.row].profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
            if let expertise = trainerList[indexPath.row].experties{
                let expertiseName = expertise.map {($0.name) ?? nil}.compactMap({$0}).joined(separator: ", ")
                if expertiseName != ""{
                    cell.expertiseInLabel.text = "Expertise in:- \(expertiseName)"
                }else{
                    cell.expertiseInLabel.text = ""
                }
            }
            
            if trainerList[indexPath.row].isfriend == 0{
                cell.sendFriendRequestButton.isHidden = false
            }else{
                cell.sendFriendRequestButton.isHidden = true
            }
            cell.bookButton.tag = trainerList[indexPath.row].id ?? 0
            cell.viewDetailsButton.tag = trainerList[indexPath.row].id ?? 0
            cell.sendFriendRequestButton.tag = trainerList[indexPath.row].id ?? 0
            let rating = Double(trainerList[indexPath.row].averageRating ?? "0")
            cell.ratingView.rating = rating ?? 0
        }
    }
        
        cell.bookButton.addTarget(self, action: #selector(trainerBookButtonAction), for: .touchUpInside)
        cell.viewDetailsButton.addTarget(self, action: #selector(trainerViewDetailsButtonAction), for: .touchUpInside)
        cell.sendFriendRequestButton.addTarget(self, action: #selector(sendFriendRequestButtonAction), for: .touchUpInside)

        return cell
    }
    @objc func sendFriendRequestButtonAction(sender:UIButton){
        print("trainer id",sender.tag)
        if let trainerList = self.trainerCommunityListVM.TrainerCommunityListData?.trainers {
            for (_,item) in trainerList.enumerated(){
                if sender.tag == item.id{
                    showFriendRequestConfirmationAlert(id:sender.tag, senderName: item.name ?? "")
                    break
                }
            }
        }
    }
    
    @objc func trainerBookButtonAction(sender:UIButton){
        print("trainer id",sender.tag)
        let mainStoryBoard = UIStoryboard(name: "Booking", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
        if let trainerList = self.trainerCommunityListVM.TrainerCommunityListData?.trainers {
            for (_,item) in trainerList.enumerated(){
                if sender.tag == item.id{
                    vc.trainerID = item.id ?? 0
                    vc.trainerName = item.name ?? ""
                    vc.avgRating = item.averageRating ?? "0"
                }
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @objc func trainerViewDetailsButtonAction(sender:UIButton){
       /* let mainStoryBoard = UIStoryboard(name: "Search", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ViewDetailsViewController") as! ViewDetailsViewController
        vc.comingFrom = "Trainer"*/
        let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
        if let trainerList = self.trainerCommunityListVM.TrainerCommunityListData?.trainers {
            for (_,item) in trainerList.enumerated(){
                if sender.tag == item.id{
                    vc.userID = item.id ?? 0
                    if item.isfriend != 0{
                    vc.comingFrom = "friend"
                    }
                }
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureCommunityListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityListSearchSectionCell") as? CommunityListSearchSectionCell else {
            fatalError("CommunityListSearchSectionCell not found")
        }
        cell.selectionStyle = .none
        if let communityList = self.trainerCommunityListVM.TrainerCommunityListData?.communities {
            cell.communityNameLabel.text = communityList[indexPath.row].name
            cell.communityDescriptionLabel.text = communityList[indexPath.row].communityDescription
            cell.totalUserCountLabel.text = "\(communityList[indexPath.row].membercount ?? 0)"
            cell.communityImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.communityImageView.sd_setImage(with: URL(string:communityList[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.joinButton.tag = communityList[indexPath.row].id ?? 0
            cell.viewDetailsButton.tag = communityList[indexPath.row].id ?? 0
        }
        cell.joinButton.addTarget(self, action: #selector(communityJoinButtonAction), for: .touchUpInside)
        cell.viewDetailsButton.addTarget(self, action: #selector(communityViewDetailsButtonAction), for: .touchUpInside)
        
        return cell
    }
    
    @objc func communityJoinButtonAction(sender:UIButton){
        //print("community id",sender.tag)
        communityJoinService(id : sender.tag)
        
    }
    @objc func communityViewDetailsButtonAction(sender:UIButton){
        let mainStoryBoard = UIStoryboard(name: "Search", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ViewDetailsViewController") as! ViewDetailsViewController
        if let communityList = self.trainerCommunityListVM.TrainerCommunityListData?.communities {
            for (_,item) in communityList.enumerated(){
                if sender.tag == item.id{
                    vc.communityData = item
                }
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension SearchVC: UITableViewDelegate {
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0
    }
}
