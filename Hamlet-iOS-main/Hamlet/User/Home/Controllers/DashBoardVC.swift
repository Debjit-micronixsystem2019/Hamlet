//
//  DashBoardVC.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift

class DashBoardVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var communityButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // MARK: - IBAction
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            communityListService(page: 0)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            commentArrayLocalCount.removeAll()
            likeArrayLocalCount.removeAll()
            isLoadingMore = false
            postListService(currentPage: 0)
        } else if segmentedControl.selectedSegmentIndex == 2 {
            bookingListService()
        }
    }
    
    @IBAction func postButtonAction (_ sender : UIButton) {
        postButton.backgroundColor = #colorLiteral(red: 0.819162786, green: 0.1134349331, blue: 0.2118148208, alpha: 1)
        communityButton.backgroundColor = #colorLiteral(red: 0.8665875793, green: 0.8667157292, blue: 0.8665712476, alpha: 1)
        postButton.setTitleColor(UIColor.white, for: .normal)
        communityButton.setTitleColor(UIColor.darkGray, for: .normal)
        postANDcommunityButtonTap = true
        likeArrayLocalCount.removeAll()
        commentArrayLocalCount.removeAll()
        isLoadingMore = false
        postListService(currentPage: 0)
    }
    
    @IBAction func communityButtonAction (_ sender : UIButton) {
        communityButton.backgroundColor = #colorLiteral(red: 0.819162786, green: 0.1134349331, blue: 0.2118148208, alpha: 1)
        postButton.backgroundColor = #colorLiteral(red: 0.8665875793, green: 0.8667157292, blue: 0.8665712476, alpha: 1)
        communityButton.setTitleColor(UIColor.white, for: .normal)
        postButton.setTitleColor(UIColor.darkGray, for: .normal)
        postANDcommunityButtonTap = false
        communityListService(page: 0)
    }
    
    // MARK: - Variables
    var postANDcommunityButtonTap : Bool = true
    var communityListVM = CommunityListViewModel()
    var postListVM = PostListViewModel()
    var communityLeaveVM = CommunityLeaveViewModel()
    var postLikeVM = PostLikeViewModel()
    var bookingListVM = BookingListViewModel()
    var postTranslateVM = PostTranslateViewModel()
    let refreshControl = UIRefreshControl()
    var postArray = [PostLstData]()
    var isLoadingMore = false
    var translateArray = [Int]()
    var communityArray = [CommunityListData]()
    var communityisLoadingMore = false

    var likeArrayLocalCount = [Int]()
    struct CommentLocalCount {
        var id, totalComment : Int
    }
    var commentArrayLocalCount = [CommentLocalCount]()
   
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if screenHeight < 700 {
            topConstraint.constant = 70
        }
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        postButton.layer.cornerRadius = 25
        communityButton.layer.cornerRadius = 25
        postButton.backgroundColor = #colorLiteral(red: 0.819162786, green: 0.1134349331, blue: 0.2118148208, alpha: 1)
        communityButton.backgroundColor = #colorLiteral(red: 0.8665875793, green: 0.8667157292, blue: 0.8665712476, alpha: 1)
        postButton.setTitleColor(UIColor.white, for: .normal)
        communityButton.setTitleColor(UIColor.darkGray, for: .normal)
        isLoadingMore = false
        likeArrayLocalCount.removeAll()
        commentArrayLocalCount.removeAll()
        communityListService(page: 0)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        if segmentedControl.selectedSegmentIndex == 0 {
            communityListService(page: 0)
        }else if segmentedControl.selectedSegmentIndex == 1 {
            isLoadingMore = false
            commentArrayLocalCount.removeAll()
            likeArrayLocalCount.removeAll()
            postListService(currentPage: 0)
        }else if segmentedControl.selectedSegmentIndex == 2{
            bookingListService()
        }
        refreshControl.endRefreshing()
    }

    // MARK: - Share Post
     func sharePost(post : String?, description : String?){
        
        let text = post ?? ""
        let description = description ?? ""
        let image = UIImage(named: "AppIcon")
        let link = URL(string: "http://text-hamletforall.com/")
        
        let shareAll = [image as Any, text, description, link as Any] as [Any]

        let activityController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        present(activityController, animated: true) {
            print("presented")
        }
    }
    
    // MARK: - Request Data To VM From UI
    func bookingListService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        bookingListVM.requestMyBookingList{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
               /* if let details = self?.bookingListVM.myBookingListResponse {
                    print("Data: ",details)
                }*/
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
    
    
     func communityListService(page : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        communityListVM.requestCommunityDetails(currentPage: page){ [weak self] (result) in
            switch result {
            case .success:
                
                if let details = self?.communityListVM.communityDetails?.data {
                    if self!.communityisLoadingMore{
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
    
    func postListService(currentPage : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        postListVM.requestPostList(currentPage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.postListVM.postListData?.data {
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

    
    private func communityLeaveService(id : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        communityLeaveVM.requestCommunityLeave( with: id){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.communityLeaveVM.communityLeaveData{
                    print("Data: ",details)
                    HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(details.data ?? "")", controller: self!, completion: nil)
                    self?.communityListService(page: 0)
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
                if let details = self?.postLikeVM.postLikeResponceData {
                    print("Data: ",details)
                    
                if details.data != "You have already liked!"{
                    for (_,item) in self!.postArray.enumerated(){
                        if postID == item.id{
                            self?.likeArrayLocalCount.append(postID)
                            break
                        }
                    }
                    self?.tableView.reloadData()
                }else{
                    self?.view.makeToast("You have already liked." , duration: 2.0, position: .bottom)
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
    
        
     func showCommunityLeaveAlert(id:Int, communityName : String) {
        HTAlert.showAlertWithOptions(title: "Alert!", message: "Are you sure you want to leave \(communityName) community?", firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.communityLeaveService(id : id)
            }
        }
    }
}

extension DashBoardVC : UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

