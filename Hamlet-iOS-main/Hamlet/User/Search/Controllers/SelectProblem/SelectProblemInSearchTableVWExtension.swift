//
//  SelectProblemInSearchTableVWExtension.swift
//  Hamlet
//
//  Created by admin on 11/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import SDWebImage

extension SelectProblemInSearchSectionVC: UITableViewDataSource {
    
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
            cell.problemImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.problemImage.sd_setImage(with: URL(string:problemListData[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "noImage"))
            
        }
        return cell
    }
    
}
extension SelectProblemInSearchSectionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let problemListData = self.selectProblemListVM.selectProblemResponse?.data {
            selectProblemID?(problemListData[indexPath.row].id ?? 0,problemListData[indexPath.row].name ?? "0")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
