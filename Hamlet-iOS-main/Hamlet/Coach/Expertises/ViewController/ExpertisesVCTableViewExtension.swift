//
//  ExpertisesVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/18/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension ExpertisesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = self.expertisesListVM.expertisesListResponse?.data else { return 0 }
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureSelectExpertisesTableCell(tableView, for: indexPath)
    }
    
    private func configureSelectExpertisesTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpertisesListTableViewCell") as? ExpertisesListTableViewCell else {
            fatalError("ExpertisesListTableViewCell not found")
        }
        if let expertisesListData = self.expertisesListVM.expertisesListResponse?.data {
            cell.expertisesNameLabel.text = expertisesListData[indexPath.row].name ?? ""
            cell.expertisesDescriptionTextView.text = expertisesListData[indexPath.row].datumDescription ?? ""
            cell.expertisesImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.expertisesImage.sd_setImage(with: URL(string:expertisesListData[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            
            cell.selectUnselectButton.tag = expertisesListData[indexPath.row].id ?? 0
            if selectArray.contains(expertisesListData[indexPath.row].id ?? 0){
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
extension ExpertisesViewController: UITableViewDelegate {
}
