//
//  CoachHomeViewTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import MBProgressHUD

extension CoachHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      guard let rows = bookingListVM.myBookingListResponse?.data else { return 0 }
        return rows.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return configureBookingListTableCell(tableView, for: indexPath)
    }
    
    // Configures Table Cell
    
    private func configureBookingListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell") as? BookingTableViewCell else {
            fatalError("BookingTableViewCell not found")
        }
        cell.selectionStyle = .none
        cell.viewDetailsAction {
            print("clicked")
            let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewDetailsVC") as! FriendsViewDetailsVC
            //vc.from = "user"
            vc.comingFrom = "friend"
            if let bookingList = self.bookingListVM.myBookingListResponse?.data {
                vc.userID = bookingList[indexPath.row].user?.id ?? 0
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if let bookingList = bookingListVM.myBookingListResponse?.data {
            cell.trainerName.text = bookingList[indexPath.row].user?.name
            cell.meetingDescription.text = bookingList[indexPath.row].bookingAt
            //UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
            cell.trainerImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.trainerImage.sd_setImage(with: URL(string:bookingList[indexPath.row].user?.image ?? ""), placeholderImage: UIImage(named: "noImage"))
            //let rating = Double(bookingList[indexPath.row].user?.averageRating ?? "0")
           // cell.ratingView.rating = rating ?? 0
        }
        cell.callButton.addTarget(self, action: #selector(callJoinButtonAction), for: .touchUpInside)
        
        return cell
    }
    
//    @objc func callJoinButtonAction(sender:UIButton) {
//        guard let url = URL(string: "https://us04web.zoom.us/j/73902496544?pwd=bnFSWGVwUkh5QVBXYmRIY3dSTlZ2dz09") else { return }
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
//    }

    @objc func callJoinButtonAction(sender: UIButton) {
        if let bookingList = bookingListVM.myBookingListResponse?.data {
            if bookingList[sender.tag].meetings?.first?.startURL != nil {
                self.connectZoomMethod(with: bookingList[sender.tag].meetings?.first?.joinURL ?? "")
            } else {
                DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
                bookingListVM.requestZoomUrl(with: bookingList[sender.tag].trainer?.name ?? "", userId: bookingList[sender.tag].userID ?? 0, bookigId: bookingList[sender.tag].id ?? 0) { [weak self] (result) in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                        self?.bookingListService()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self?.connectZoomMethod(with: bookingList[sender.tag].meetings?.first?.startURL ?? "")
                        }
                    case .failure(let error):
                        print(error.description)
                        HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                        DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
                    }
                }
            }
        }
    }
    
    func connectZoomMethod(with url: String) {
        guard let url = URL(string: url) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

extension CoachHomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
}
