//
//  EmailVerifyVC.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class CommentOnPostVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var addCommentTextView: UITextView! {
        didSet {
            addCommentTextView.layer.cornerRadius = 12.0
        }
    }
    
    @IBOutlet weak var addCommentButton: UIButton!{
        didSet {
            addCommentButton.layer.cornerRadius = 10.0
            addCommentButton.clipsToBounds = true
        }
    }
    
    @IBAction func addCommentButtonAction(_ sender: Any) {
        if (addCommentTextView.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "Write something in the comment box.", controller: self, completion: nil)
        }else{
            postCommentService(postID:postData?.id ?? 0, comment:addCommentTextView.text ?? "")
        }
    }
    
    var postData : PostLstData? = nil
    var commentListVM = CommentListViewModel()
    var postCommentVM = PostCommentViewModel()
    var commentStatus : ((Bool)->())!
    var totalComment : ((Int)->())!
    let refreshControl = UIRefreshControl()
    var commentListArray = [CommentListData]()
    var isLoadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Post"
        setUI()
    }
    
    func setUI(){
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        postNameLabel.text = postData?.title
        postDescriptionLabel.text = postData?.body
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        postImageView.sd_setImage(with: URL(string:postData?.image ?? ""), placeholderImage: UIImage(named: "noImage"))
        postImageView.roundedImage()
        isLoadingMore = false
        commentListService(postID:postData?.id ?? 0, currentPage: 0)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        isLoadingMore = false
        commentListService(postID:postData?.id ?? 0, currentPage: 0)
        refreshControl.endRefreshing()
    }
    
    // MARK: - Request Data To VM From UI
     func commentListService(postID:Int, currentPage :Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        commentListVM.requestCommentList(with: postID, currentPage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.commentListVM.commentListData {
                // print("Data: ",details)
                    self?.totalComment?((details.total)!)
                     if self!.isLoadingMore{
                        self?.commentListArray += details.data ?? []
                     }else{
                        self?.commentListArray = details.data ?? []
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
    
    private func postCommentService(postID:Int, comment:String) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        postCommentVM.requestToPostComment(with: postID, comment: comment){ [weak self] (result) in
            switch result {
            case .success:
                self?.isLoadingMore = false
                self?.commentListService(postID:self?.postData?.id ?? 0, currentPage: 0)
                self?.commentStatus?(true)
                self?.addCommentTextView.text = nil
                /* if let details = self?.CommunityListVM.communityDetails {
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
}
