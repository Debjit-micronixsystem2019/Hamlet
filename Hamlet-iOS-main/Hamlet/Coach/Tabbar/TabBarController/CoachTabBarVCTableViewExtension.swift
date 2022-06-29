//
//  CoachTabBarVCTableViewExtension.swift
//  Hamlet
//
//  Created by admin on 11/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit

extension CoachTabBarController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureMenuListTableCell(tableView, for: indexPath)
    }
    
    //MARK:-AllNotificationList
    private func configureMenuListTableCell(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as? MenuTableViewCell else {
            fatalError("MenuTableViewCell not found")
        }
        cell.selectionStyle = .none
        cell.menuItemLabel.text = menuArray[indexPath.row]
        return cell
    }
}

extension CoachTabBarController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuView.removeFromSuperview()
        if indexPath.row == 0{
            let mainStoryBoard = UIStoryboard(name: "CreateCommunity", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CommunityListViewController") as! CommunityListViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row == 1{
            let mainStoryBoard = UIStoryboard(name: "Expertises", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ExpertisesViewController") as! ExpertisesViewController
            vc.comingFrom = "EditExpertise"
            self.present(vc, animated: true, completion: nil)
            
        }else if indexPath.row == 2{
            let mainStoryBoard = UIStoryboard(name: "Newsletter", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "NewsletterViewController") as! NewsletterViewController
            vc.webload = "About"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row == 3{
            let mainStoryBoard = UIStoryboard(name: "Newsletter", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "NewsletterViewController") as! NewsletterViewController
            vc.webload = "ContactUs"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row == 4{
            let mainStoryBoard = UIStoryboard(name: "Newsletter", bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "NewsletterViewController") as! NewsletterViewController
            vc.webload = "Privacy"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row == 5{
            showSignOutAlert()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    private func showSignOutAlert() {
        HTAlert.showAlertWithOptions(title: "Sign Out", message: "Are you sure you want to sign out?", firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                UserDefaults.standard.removeObject(forKey: "selectExpertisesSubmit")
                UserDefaults.standard.removeObject(forKey: "selectProblemSubmit")
                UserDefaults.standard.removeObject(forKey: "UserName")
                UserDefaults.standard.removeObject(forKey: Defaults.userProfileUrl)
                self.signOut()
            }
        }
    }
    
    private func signOut() {
        let mainStoryBoard = UIStoryboard(name: "LogIn", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

