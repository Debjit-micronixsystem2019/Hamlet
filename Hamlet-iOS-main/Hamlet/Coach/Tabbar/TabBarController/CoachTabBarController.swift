//
//  CoachTabBarController.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import SDWebImage

class CoachTabBarController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var navView : UIView!
    @IBOutlet weak var navViewLblTitle : UILabel!
    @IBOutlet weak var menuView : UIView!
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var TableView : UITableView!


    // MARK: - IBAction
    @IBAction func menuButtonAction(_ sender: Any){
        self.menuView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height+60)
        // menuView.frame = UIApplication.shared.keyWindow!.frame
        UIApplication.shared.keyWindow!.addSubview(menuView)
        profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        guard let profileImage = UserDefaults.standard.value(forKey: Defaults.userProfileUrl) else {return}
        profileImageView.sd_setImage(with: URL(string: profileImage as! String), placeholderImage: UIImage(systemName: "person.circle.fill"))
    }
    
    @IBAction func removeMenuViewAction(_ sender: Any){
        menuView.removeFromSuperview()
    }
    
    // MARK: - Variable
    var menuArray = ["My Community","Select Expertise","About Us","Contact Us","Privacy","Logout"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        navViewLblTitle.text = "My Booking"
        TableView.delegate = self
        TableView.dataSource = self
        TableView.layer.cornerRadius = 20
        nameLabel.text = AppLaunch.shared.userName
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationViewInHeader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navView.removeFromSuperview()
    }
    // MARK: - Set Navigation View Header
    func setNavigationViewInHeader(){
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if UIDevice.current.name == "iPhone SE"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65))
            
        }else if UIDevice.current.name == "iPhone 7"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65))
            
        }else if UIDevice.current.name == "iPhone 7 Plus"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65))
            
        }else if UIDevice.current.name == "iPhone 8"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
            
        }else if UIDevice.current.name == "iPhone 8 Plus"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
            
        }else if UIDevice.current.name == "iPhone X"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90))
            
        }else if UIDevice.current.name == "iPhone XS"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90))
            
        }else if UIDevice.current.name == "iPhone XS Max"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90))
        }
        else if UIDevice.current.name == "iPhone XR"{
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 87))
        }else {
            self.navView.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90))
        }
        self.navigationController?.view.addSubview(navView)
        self.delegate = self
    }
}

extension CoachTabBarController {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex == 0 {
            self.navViewLblTitle.text = "My Bookings"
        }
        else if selectedIndex == 1{
            self.navViewLblTitle.text = "Chat"
        } else if selectedIndex == 2 {
            self.navViewLblTitle.text = "Search"
        }else if selectedIndex == 3 {
            self.navViewLblTitle.text = "Notification"
        }else if selectedIndex == 4 {
            self.navViewLblTitle.text = "My Profile"
        }
    }
}
