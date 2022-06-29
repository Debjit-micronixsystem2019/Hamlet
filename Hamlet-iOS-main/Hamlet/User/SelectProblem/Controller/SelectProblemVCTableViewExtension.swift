//
//  SelectProblemVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 10/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension SelectProblemVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = self.selectProblemListVM.selectProblemResponse?.data else { return 0 }
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureSelectProblemTableCell(tableView, for: indexPath)
    }
    
    private func configureSelectProblemTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectProblemTableViewCell") as? SelectProblemTableViewCell else {
            fatalError("SelectProblemTableViewCell not found")
        }
        if let problemListData = self.selectProblemListVM.selectProblemResponse?.data {
            cell.problemNameLabel.text = problemListData[indexPath.row].name ?? ""
            cell.problemDescriptionTextView.text = problemListData[indexPath.row].problemDescription ?? ""
            cell.problemImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.problemImage.sd_setImage(with: URL(string:problemListData[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            cell.selectUnselectButton.tag = problemListData[indexPath.row].id ?? 0
            if selectArray.contains(problemListData[indexPath.row].id ?? 0){
                cell.selectUnselectButton.setImage(UIImage(named: "select-problem"), for: .normal)
            }else{
                cell.selectUnselectButton.setImage(UIImage(named: "Unselect"), for: .normal)
            }
        }
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
        //print(selectArray)
        tableView.reloadData()
    }
}
extension SelectProblemVC: UITableViewDelegate {
}
