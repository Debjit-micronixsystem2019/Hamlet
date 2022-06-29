//
//  ParticipateViewController.swift
//  Hamlet
//
//  Created by admin on 5/20/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class ParticipateViewController: UIViewController {

    @IBOutlet weak var communityImageView: UIImageView!
    @IBOutlet weak var communityNameLabel: UILabel!
    @IBOutlet weak var communityDescriptionLabel: UILabel!
    @IBOutlet weak var communityUserCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalUserBackView: UIView!{
        didSet{
            totalUserBackView.layer.cornerRadius = 5
            //totalUserBackView.clipsToBounds = true
        }
    }
    @IBOutlet weak var addPostButton: UIButton!{
        didSet {
            addPostButton.layer.cornerRadius = 22.0
            addPostButton.clipsToBounds = true
        }
    }

    
    @IBAction func addPostButtonAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Communities", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "PostsOnCommunityVC") as! PostsOnCommunityVC
        vc.modalPresentationStyle = .overFullScreen
        vc.communityID = commynityData?.id ?? 0
        vc.communityStatus = commynityData?.status ?? 0
        vc.postStatus = { (status) in
            if status{
                self.isLoadingMore = false
                self.postListServiceCommunityWise(communityID:self.commynityData?.id ?? 0, currentPage: 0)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "CreateCommunity", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CreateCommunityViewController") as! CreateCommunityViewController
        vc.communityID = commynityData?.id ?? 0
        vc.communityTitle = commynityData?.name ?? ""
        vc.communityDescription = commynityData?.dataDescription ?? ""
        vc.updateCommunityStatus = { (update_name, update_description) in
            self.communityNameLabel.text = update_name 
            self.communityDescriptionLabel.text = update_description 
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func totalUserButtonAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "CreateCommunity", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "RemoveUserFromCommunityViewController") as! RemoveUserFromCommunityViewController
        vc.community_id = commynityData?.id ?? 0
        vc.community_name = commynityData?.name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }

    var commynityData : CommunityListData? = nil
    var communityWisePostListVM = CommunityWisePostListViewModel()
    var postTranslateVM = PostTranslateViewModel()
    let refreshControl = UIRefreshControl()
    var postArray = [PostLstData]()
    var isLoadingMore = false
    var translateArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Community"
        setUI()
    }
    
    
    func setUI(){
        communityNameLabel.text = commynityData?.name ?? ""
        communityDescriptionLabel.text = commynityData?.dataDescription ?? ""
        communityUserCountLabel.text = "\(commynityData?.communityMembersCount ?? 0)"
        communityImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        communityImageView.sd_setImage(with: URL(string:commynityData?.image ?? ""), placeholderImage: UIImage(named: "noImage"))
        communityImageView.roundedImage()
        postListServiceCommunityWise(communityID:commynityData?.id ?? 0, currentPage: 0)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        //print(123)
        postListServiceCommunityWise(communityID:commynityData?.id ?? 0, currentPage: 0)
        refreshControl.endRefreshing()
    }
    
    
    func postListServiceCommunityWise(communityID:Int, currentPage:Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        communityWisePostListVM.requestPostListCommunityWise(with: communityID, currentPage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.communityWisePostListVM.postListData?.data {
                    if self!.isLoadingMore{
                        self?.postArray += details
                    }else{
                        self?.postArray = details
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
    
    func posTranslateService(postID: Int, translateID: Int, index : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        postTranslateVM.requestForPostTranslate(with: translateID, postID: postID){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.postTranslateVM.postTranslateResponce {
                    //  print("Data: ",details)
                    self?.transelectCell(index: index)
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
}


