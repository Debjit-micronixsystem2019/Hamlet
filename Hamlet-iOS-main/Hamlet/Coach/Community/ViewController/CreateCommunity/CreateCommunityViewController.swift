//
//  CreateCommunityViewController.swift
//  Hamlet
//
//  Created by admin on 5/20/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class CreateCommunityViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var communityNameTextField: UITextField!
    @IBOutlet weak var communityDescriptionTextView: UITextView!{
        didSet{
            communityDescriptionTextView.layer.cornerRadius = 5
            communityDescriptionTextView.layer.borderWidth = 0.5
            communityDescriptionTextView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var invitesButton: UIButton!
    
    // MARK: - IBAction
    @IBAction func createCommunitiesButtonAction (_ sender : UIButton) {
        if (communityNameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "Please enter a community name.", controller: self, completion: nil)
        }else if (communityDescriptionTextView.text!.trimmingCharacters(in: .whitespaces).isEmpty){
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "Please write about community descriptions.", controller: self, completion: nil)
        }else{
            if comingFrom == "CreateCommunity"{
            createcommunitiesService(name: communityNameTextField.text!,
                                     description: communityDescriptionTextView.text!)
            }else{
            updatecommunitiesService(name : communityNameTextField.text!, description : communityDescriptionTextView.text!)
            }
        }
    }
    
    // MARK: - Variables
    var createCommunityVM = CreateCommunityViewModel()
    var updateCommunityVM = UpdateCommunityViewModel()
    var comingFrom = ""
    var communityID = Int()
    var communityTitle = ""
    var communityDescription = ""
    var updateCommunityStatus : ((String,String)->())!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        if comingFrom == "CreateCommunity"{
            self.title = "Create Community"
            invitesButton.setTitle("Create Community", for: .normal)
        }else{
            self.title = "Update Community"
            invitesButton.setTitle("Update Community", for: .normal)
            communityNameTextField.text = communityTitle
            communityDescriptionTextView.text = communityDescription
        }
        invitesButton.layer.cornerRadius = 20
    }
    
    private func createcommunitiesService(name : String, description : String) {
         DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        createCommunityVM.requestForCreateCommunity(with: name, description: description){ [weak self] (result) in
             switch result {
             case .success:
                self?.communityNameTextField.text = nil
                self?.communityDescriptionTextView.text = nil
                self?.createCommunitiesSucessAlert(communityName: name)
                /* if let details = self?.createGroupChatVM.allUserListResponse {
                     print("Data: ",details)
                 }*/
                 DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
             case .failure(let error):
                 print(error.description)
                 HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                 DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

             }
         }
     }
    
    func createCommunitiesSucessAlert(communityName : String) {
           let alertController = UIAlertController(title: "Successfully!", message: "\(communityName) communites created successfully.", preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
    
    private func updatecommunitiesService(name : String, description : String) {
         DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        updateCommunityVM.requestForUpdateCommunity(with: name, description: description, communityID: communityID){ [weak self] (result) in
             switch result {
             case .success:
                self?.updateCommunityStatus?(name, description)
                self?.updateCommunitiesSucessAlert(communityName: name)
                /* if let details = self?.createGroupChatVM.allUserListResponse {
                     print("Data: ",details)
                 }*/
                 DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
             case .failure(let error):
                 print(error.description)
                 HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                 DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

             }
         }
     }
    
    func updateCommunitiesSucessAlert(communityName : String) {
           let alertController = UIAlertController(title: "Successfully!", message: "\(communityName) communites updated successfully.", preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
}

