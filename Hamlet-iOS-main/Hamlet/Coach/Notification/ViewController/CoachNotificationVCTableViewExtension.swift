//
//  CoachNotificationVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/24/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension CoachNotificationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = self.notificationListVM.notificationListResponse else { return 0 }
            return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return configureAllFriendRequestesListTableCell(tableView, for: indexPath)
    }
    
    //MARK:-AllNotificationList
    private func configureAllFriendRequestesListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoachNotificationTableViewCell") as? CoachNotificationTableViewCell else {
            fatalError("CoachNotificationTableViewCell not found")
        }
        cell.selectionStyle = .none
        if let notificatioonListData = self.notificationListVM.notificationListResponse {
            cell.nameLabel.text = notificatioonListData[indexPath.row].body ?? ""
        }
        return cell
    }
}

extension CoachNotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
