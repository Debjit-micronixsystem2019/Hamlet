//
//  CommunityVC.swift
//  Hamlet
//
//  Created by Basir Alam on 04/11/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class CommunitiesVC: UIViewController {

    @IBOutlet weak var communityImageView: UIImageView!
    @IBOutlet weak var communityNameLabel: UILabel!
    @IBOutlet weak var communityDescriptionLabel: UILabel!
    @IBOutlet weak var communityUserCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addPostButton: UIButton!{
        didSet {
            addPostButton.layer.cornerRadius = 22.0
            addPostButton.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var joinButton: UIButton!{
        didSet {
            joinButton.layer.cornerRadius = 20.0
            joinButton.clipsToBounds = true
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
                self.commentArrayLocalCount.removeAll()
                self.likeArrayLocalCount.removeAll()
                self.isLoadingMore = false
                self.postListServiceCommunityWise(communityID:self.commynityData?.id ?? 0, currentPage: 0)
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    var commynityData : CommunityListData? = nil
    var communityWisePostListVM = CommunityWisePostListViewModel()
    var postLikeVM = PostLikeViewModel()
    var postTranslateVM = PostTranslateViewModel()

    let refreshControl = UIRefreshControl()
    var postArray = [PostLstData]()
    var isLoadingMore = false
    var translateArray = [Int]()
    var likeArrayLocalCount = [Int]()
    
    struct CommentLocalCount {
        var id, totalComment : Int
    }
    var commentArrayLocalCount = [CommentLocalCount]()

    
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
        
        isLoadingMore = false
        likeArrayLocalCount.removeAll()
        commentArrayLocalCount.removeAll()
        postListServiceCommunityWise(communityID:commynityData?.id ?? 0, currentPage: 0)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        isLoadingMore = false
        likeArrayLocalCount.removeAll()
        commentArrayLocalCount.removeAll()
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
    
    
    func postLikeService(postID:Int) {
        //DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        postLikeVM.requestPostLike(with: postID){ [weak self] (result) in
            switch result {
            case .success:
               // self?.postListServiceCommunityWise(communityID:self?.commynityData?.id ?? 0)
                if let details = self?.postLikeVM.postLikeResponceData {
                    //print("Data: ",details)
                    if details.data != "You have already liked!"{
                        for (_,item) in self!.postArray.enumerated(){
                            if postID == item.id{
                                self?.likeArrayLocalCount.append(postID)
                                break
                            }
                        }
                        self?.tableView.reloadData()
                      }
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

