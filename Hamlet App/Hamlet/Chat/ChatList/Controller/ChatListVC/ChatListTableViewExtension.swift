//
//  ChatTableViewExtension.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

extension ChatListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let rows = self.homeVM.paymentHistory else { return 0 }
        return 10//rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureRentTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    private func configureRentTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ChatListCell else {
            fatalError("ChatViewCell not found")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Chat", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(identifier: "ChatVC") as! ChatVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

