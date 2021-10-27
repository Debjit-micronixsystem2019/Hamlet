//
//  DashBoardTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit


extension DashBoardVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //   guard let rows  = 10 else { return 0 }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch postANDcommunityButtonTap {
        case true:
            return configurePostTableCell(tableView, for: indexPath)
        case false:
            return configureCommunityTableCell(tableView, for: indexPath)
        }
    }
    
    // Configures Table Cell
    private func configurePostTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else {
            fatalError("HomeTableViewCell not found")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func configureCommunityTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as? CommunityTableViewCell else {
            fatalError("HomeTableViewCell not found")
        }
        cell.selectionStyle = .none
       /* if let paymentHistory = self.homeVM.paymentHistory {
            cell.amountLabel.text = "$ \(paymentHistory[indexPath.row].paidAmount ?? 0)"
            cell.monthLabel.text = "\(paymentHistory[indexPath.row].paymentDesc ?? "") Rent"
            cell.receiptNoLabel.text = "Receipt No: \(paymentHistory[indexPath.row].receiptNo ?? "")"
        }*/
        return cell
    }

}

extension DashBoardVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
