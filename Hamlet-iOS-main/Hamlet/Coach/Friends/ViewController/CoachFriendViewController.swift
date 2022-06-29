//
//  CoachFriendViewController.swift
//  Hamlet
//
//  Created by admin on 11/19/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class CoachFriendViewController: UIViewController {

   // MARK: - IBOutlet
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.layer.cornerRadius = 20.0
            searchButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchBackView: UIView!
    
    // MARK: - IBAction
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            searchBackView.isHidden = false
            isLoadingMore = false
            allFriendsListService(currentPage: 0)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            searchBackView.isHidden = true
            friendsRequestListService()
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var allFriendsListVM = AllFriendsListViewModel()
    var friendsRequestListVM = FriendsRequestListViewModel()
    var sendFriendRequestVM = SendFriendRequestViewModel()
    var friendRequestAcceptRejectVM = FriendRequestAcceptRejectViewModel()
    lazy var filterArray: [AllFriendsListData] = []
    var searching : Bool = false
    let refreshControl = UIRefreshControl()
    
    var myFriendListArray = [AllFriendsListData]()
    var isLoadingMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
         setUI()
    }
    
    func setUI(){
        isLoadingMore = false
        allFriendsListService(currentPage: 0)
        searchBackView.layer.cornerRadius = 6
        searchTextField.addTarget(self, action: #selector(CoachSearchViewController.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: searchTextField.frame.height))
        searchTextField.leftViewMode = .always
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        if segmentedControl.selectedSegmentIndex == 0 {
            isLoadingMore = false
            allFriendsListService(currentPage: 0)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            friendsRequestListService()
        }
        refreshControl.endRefreshing()
    }
    
    // MARK: - Data Received From VM
    private func friendsRequestListService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        friendsRequestListVM.riendsRequestList{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
               /* if let details = self?.allFriendsListVM.allUserListResponse {
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
    
     func allFriendsListService(currentPage : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        allFriendsListVM.requestAllFriendsList(currentPage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.allFriendsListVM.allFriendsListResponse {
                    if self!.isLoadingMore{
                        self?.myFriendListArray += details.data ?? []
                    }else{
                        self?.myFriendListArray = details.data ?? []
                    }
                    self?.tableView.reloadData()
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
    
    
    private func sendFriendequestService(id : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        sendFriendRequestVM.requestSendFriendRequest( with: id){ [weak self] (result) in
            switch result {
            case .success:
                
                HTAlert.showAlertWithTitle(title: AlertConstants.completed, message: "Friend request has been successfully sent!", controller: self!, completion: nil)
                
                //self?.tabelView.reloadData()
                /*if let details = self?.trainerCommunityListVM.TrainerCommunityListData{
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
    
    private func friendequestAcceptRejectService(id : Int, accept : Bool) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        friendRequestAcceptRejectVM.requestFriendRequestAcceptReject( with: id, accept: accept){ [weak self] (result) in
            switch result {
            case .success:
                self?.friendsRequestListService()
                if let details = self?.friendRequestAcceptRejectVM.friendRequestAcceptRejectResponse{
                    print("Data: ",details)
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
    
    
    func showFriendRequestConfirmationAlert(id:Int,senderName : String) {
        HTAlert.showAlertWithOptions(title: "Confirmation!", message: "Would you like to send a friend request to \(senderName)", firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.sendFriendequestService(id : id)
            }
        }
    }
    
    func showFriendRequestAcceptRejectConfirmationAlert(id:Int,accept : Bool, message : String) {
        HTAlert.showAlertWithOptions(title: "Confirmation!", message: message, firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.friendequestAcceptRejectService(id : id, accept : accept)
            }
        }
    }
}

extension CoachFriendViewController : UITextFieldDelegate{
    
    @objc func textFieldDidChange(textField : UITextField){
        if searchTextField.text?.count == 0{
            searching = false
            tableView.reloadData()
        }else{
            if self.allFriendsListVM.allFriendsListResponse?.data?.count != 0{
              //  NonFilterArray = data.filter({$0.name!.prefix(searchTextField.text!.count) == searchTextField.text!.lowercased()})
                filterArray = myFriendListArray.filter({ (mod) ->Bool in
                    return (mod.name?.lowercased().contains(searchTextField.text!.lowercased()))!
                })
           // print("filterArray",filterArray)
            searching = true
            tableView.reloadData()
        }
    }
}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  print("textFieldBegin",textField.text)
        searching = false
        tableView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}
