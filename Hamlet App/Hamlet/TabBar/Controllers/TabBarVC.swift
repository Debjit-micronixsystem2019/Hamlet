//
//  TabBarVC.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var navView : UIView!
    @IBOutlet weak var navViewLblTitle : UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        navViewLblTitle.text = "Dashboard"
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

extension TabBarVC {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex == 0 {
            self.navViewLblTitle.text = "Dashboard"
        }
        else if selectedIndex == 1{
           self.navViewLblTitle.text = "Chat"
        }
        else if selectedIndex == 2 {
            self.navViewLblTitle.text = "Search"
        }else if selectedIndex == 3 {
            self.navViewLblTitle.text = "Profile"
        }
    }
}
