//
//  FriendsViewDetailsTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/16/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit

extension FriendsViewDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comingFrom != "friend" && comingFrom != "Coachfriend" {
            return 2
        }else{
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureProfileTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    private func configureProfileTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as? ProfileTableViewCell else {
            fatalError("ProfileTableViewCell not found")
        }
        cell.selectionStyle = .none
        
        if let profileData = self.userViewDetailsVM.userDetailsResponse {
            
            if comingFrom != "friend" && comingFrom != "Coachfriend"{
                switch indexPath.row {
                        case 0:
                            cell.itemDescriptionLabel.text = profileData.name
                            cell.itemLabel.text = "Name"
                        case 1:
                            cell.itemLabel.text = "Email"
                            cell.itemDescriptionLabel.text = profileData.email
                        default:
                            break
                }
            }else{
                switch indexPath.row {
                        case 0:
                            cell.itemDescriptionLabel.text = profileData.name
                            cell.itemLabel.text = "Name"
                        case 1:
                            cell.itemLabel.text = "Email"
                            cell.itemDescriptionLabel.text = profileData.email
                        case 2:
                            cell.itemLabel.text = "Email verified at"
                            cell.itemDescriptionLabel.text = profileData.emailVerifiedAt?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
                        case 3:
                            cell.itemLabel.text = "Date of birth"
                            cell.itemDescriptionLabel.text = profileData.dob
                        case 4:
                            cell.itemLabel.text = "Phone"
                            cell.itemDescriptionLabel.text = profileData.phone
                        case 5:
                            cell.itemLabel.text = "Gender"
                            cell.itemDescriptionLabel.text = profileData.gender
                        default:
                            break
                    
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }*/
}
