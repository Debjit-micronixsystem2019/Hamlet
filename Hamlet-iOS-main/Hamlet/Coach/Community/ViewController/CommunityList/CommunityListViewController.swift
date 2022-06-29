//
//  CommunityListViewController.swift
//  Hamlet
//
//  Created by admin on 5/20/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift

class CommunityListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var createCommunityButton: UIButton!{
        didSet {
            createCommunityButton.layer.cornerRadius = 22.0
            createCommunityButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView!

    // MARK: - IBAction
    @IBAction func createCommunityButtonAction (_ sender : UIButton) {
         let mainStoryBoard = UIStoryboard(name: "CreateCommunity", bundle: nil)
         let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CreateCommunityViewController") as! CreateCommunityViewController
          vc.comingFrom = "CreateCommunity"
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Variables
    var communityListVM = FetchCreateCommunityListViewModel()
    let refreshControl = UIRefreshControl()
    var communityArray = [CommunityListData]()
    var isLoadingMore = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Community"
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        communityListService(currentPage: 0)
        refreshControl.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        communityListService(currentPage: 0)
    }
    
    // MARK: - Request Data To VM From UI
     func communityListService(currentPage: Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        communityListVM.requestForCreateCommunityList(currentPage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.communityListVM.communityDetails?.data {
                    if self!.isLoadingMore{
                        self?.communityArray += details
                    }else{
                        self?.communityArray = details
                    }
                }
                self?.tableView.reloadData()
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }        
}

