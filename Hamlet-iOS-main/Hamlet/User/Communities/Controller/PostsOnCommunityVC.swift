//
//  EmailVerifyVC.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class PostsOnCommunityVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postTitleField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var emailVerifyView: UIView!
    
    // MARK: - IBAction
    @IBAction func postAction (_ sender : UIButton) {
        if (postTitleField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "*Can't be blank post title field.", controller: self, completion: nil)
        }else if postTextView.text == "Write something to post.."{
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "Write something to post description.", controller: self, completion: nil)
        }else{
            postOnCommunity(communityID:communityID,
                            title:postTitleField.text ?? "",
                            status:communityStatus,
                            postData:postTextView.text ?? "")
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var postOnCommunityVM = PostOnCommunityViewModel()
    var communityID = Int()
    var communityStatus = Int()
    var postStatus : ((Bool)->())!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        emailVerifyView.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 20
        closeButton.layer.cornerRadius = 10
        closeButton.layer.cornerRadius = 20
        postTextView.text = "Write something to post.."
        postTextView.textColor = UIColor.lightGray
        postTextView.delegate = self
    }
    
    private func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func postOnCommunity(communityID:Int,title:String,status:Int,postData:String) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        postOnCommunityVM.requestPostOnCommunity(with: communityID,title: title,status: status,postText: postData){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.postOnCommunityVM.postOnCommunityData {
                    print("Data: ",details)
                
                self?.postTextView.text = "Write something to post.."
                self?.postTextView.textColor = UIColor.lightGray
                self?.postTitleField.text = nil
                self?.postTitleField.placeholder = "Post title"
                self?.postStatus?(true)
                    self?.showPostAlert(AlertMessage : details.data ?? "")
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
    
    
    func showPostAlert(AlertMessage : String) {
           let alertController = UIAlertController(title: "Alert!", message: AlertMessage, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
               self.dismiss(animated: true, completion: nil)
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
}


extension PostsOnCommunityVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if postTextView.textColor == UIColor.lightGray {
            postTextView.text = nil
            postTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if postTextView.text.isEmpty {
            postTextView.text = "Write something to post.."
            postTextView.textColor = UIColor.lightGray
        }
    }
}
