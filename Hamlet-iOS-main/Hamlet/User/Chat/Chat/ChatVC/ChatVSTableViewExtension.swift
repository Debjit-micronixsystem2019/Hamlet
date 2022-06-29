//
//  ChatVSTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 10/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

extension ChatVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  guard let rows = self.GetChatMessageVM.GetChatMessageResponse?.data else { return 0 }
        return chatMessageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let userid = UserDefaults.standard.value(forKey: Defaults.userId) as! Int
      //  if self.GetChatMessageVM.GetChatMessageResponse?.data![indexPath.row].user?.id
            
        if chatMessageArray[indexPath.row].user?.id == userid{
            let cell = setOutgoingCell(tableview: tableView, indexPath: indexPath)
            return cell
        }else{
            let cell = setIncomingCell(tableview: tableView, indexPath: indexPath)
            return cell
        }
    }
    
    // MARK: - Helper Method for tableview cell for incoming design...
    private func setIncomingCell(tableview: UITableView, indexPath: IndexPath) -> IncomingCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IncomingCell.identifier, for: indexPath) as! IncomingCell
        cell.selectionStyle = .none
       // if let GetChatMessageData = self.GetChatMessageVM.GetChatMessageResponse?.data?[indexPath.row] {
        cell.setMessage(chatMessageArray[indexPath.row])
            
            if translateArray.contains(chatMessageArray[indexPath.row].id ?? 0){
                cell.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                if let details = self.translateChatMessageVM.translateChatMessageResponse {
                    cell.messageLabel.text = details.data
                }
                
            }else{
                cell.contentView.backgroundColor = UIColor.white
            }
       // }
        
        return cell
    }
    // MARK: - Helper Method for tableview cell for outgoing design...
    private func setOutgoingCell(tableview: UITableView, indexPath: IndexPath) -> OutgoingCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingCell.identifier, for: indexPath) as! OutgoingCell
        cell.selectionStyle = .none
        
       // if let GetChatMessageData = self.GetChatMessageVM.GetChatMessageResponse?.data?[indexPath.row] {
            cell.setMessage(chatMessageArray[indexPath.row])
            
            if translateArray.contains(chatMessageArray[indexPath.row].id ?? 0){
                cell.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                    if let details = self.translateChatMessageVM.translateChatMessageResponse {
                        cell.messageLabel.text = details.data
                    }
            }else{
                cell.contentView.backgroundColor = UIColor.white
            }
     //   }

        return cell
    }
}

extension ChatVC: UITableViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let allChatListData = self.GetChatMessageVM.GetChatMessageResponse{
           let contentOffset = scrollView.contentOffset.y
          let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
           
       // print("contentOffset",contentOffset)
       //print("maximumOffset",maximumOffset)
       // print("maximumOffset - contentOffset",maximumOffset - contentOffset)
            let threshold = Float(allChatListData.total ?? 0)
      //
            if (contentOffset <= CGFloat(threshold)) && allChatListData.nextPageURL != nil{
                print("work")
                isLoadingMore = true
                requestGetChatMessage(currentPage: allChatListData.currentPage! + 1)
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // if let GetChatMessageData = self.GetChatMessageVM.GetChatMessageResponse?.data?[indexPath.row] {
            if translateArray.contains(chatMessageArray[indexPath.row].id ?? 0){
                translateArray.removeAll()
            }else{
                let id = chatMessageArray[indexPath.row].id ?? 0
                translateArray.removeAll()
                translateArray.append(id)
                requestTranslateChatMessage(message: chatMessageArray[indexPath.row].message ?? "", message_id: chatMessageArray[indexPath.row].id ?? 0, target_lang_id: AppSettings.shared.userChatLanguageId, index :indexPath.row)
            }
      //  }
        tableView.reloadData()
    }
    
    func transelectCell(index : Int){
        let indexPath = IndexPath(item: index, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


