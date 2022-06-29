//
//  CoachSearchViewController.swift
//  Hamlet
//
//  Created by admin on 11/19/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class CoachSearchViewController: UIViewController {

// MARK: - IBOutlet
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tabelView : UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.layer.cornerRadius = 25.0
            searchButton.clipsToBounds = true
        }
    }
    
    // MARK: - IBAction
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
          // print(segmentedControl)
        } else if segmentedControl.selectedSegmentIndex == 1 {
              let mainStoryBoard = UIStoryboard(name: "CoachFriend", bundle: nil)
                let vc = mainStoryBoard.instantiateViewController(withIdentifier: "CoachFriendViewController") as! CoachFriendViewController
               vc.modalPresentationStyle = .overFullScreen
               self.present(vc, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.segmentedControl.selectedSegmentIndex = 0
            }
        }
        
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
    }
    
    
    // MARK: - Variables
    var sendFriendRequestVM = SendFriendRequestViewModel()
    var allUserListVM = AllUserListViewModel()
    lazy var filterArray: [AllUserListData] = []
    var searching : Bool = false
    let refreshControl = UIRefreshControl()
    var allUserListArray = [AllUserListData]()
    var isLoadingMore = false
    var friendRequestSendArraylocal = [Int]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if screenHeight < 700 {
            topConstraint.constant = 30
        }
    }
    
    func setUI(){
        tabelView.tableFooterView = UIView()
        searchTextField.setTextFieldShadow()
        searchTextField.setLeftPadding(36)
        searchTextField.setRightPadding(46)
        isLoadingMore = false
        friendRequestSendArraylocal.removeAll()
        allUserListService(currentPage: 0)
        searchTextField.addTarget(self, action: #selector(CoachSearchViewController.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tabelView.addSubview(refreshControl)

    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //print(123)
        isLoadingMore = false
        friendRequestSendArraylocal.removeAll()
        allUserListService(currentPage: 0)
        refreshControl.endRefreshing()
    }
    
    // MARK: - Request Data To VM From UI
    
     func allUserListService(currentPage : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        allUserListVM.requestAllUserList(with: 2, currentpage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
               if let details = self?.allUserListVM.allUserListResponse {
                   if self!.isLoadingMore{
                       self?.allUserListArray += details.data ?? []
                   }else{
                       self?.allUserListArray = details.data ?? []
                   }
               }
                self?.tabelView.reloadData()
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
                if let details = self?.sendFriendRequestVM.communityJoinData{
                  if details.status == 200{
                     for (_,item) in self!.allUserListArray.enumerated(){
                         if id == item.id{
                             self?.friendRequestSendArraylocal.append(id)
                             break
                         }
                     }
                     self?.tabelView.reloadData()
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
    
    func showFriendRequestConfirmationAlert(id:Int,senderName : String) {
        HTAlert.showAlertWithOptions(title: "Confirmation!", message: "Would you like to send a friend request to \(senderName)", firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.sendFriendequestService(id : id)
            }
        }
    }
}

extension CoachSearchViewController : UITextFieldDelegate{
    
    @objc func textFieldDidChange(textField : UITextField){
        if searchTextField.text?.count == 0{
            searching = false
            tabelView.reloadData()
        }else{
            if self.allUserListVM.allUserListResponse?.data?.count != 0{

              //  NonFilterArray = data.filter({$0.name!.prefix(searchTextField.text!.count) == searchTextField.text!.lowercased()})
                filterArray = allUserListArray.filter({ (mod) ->Bool in
                    return (mod.name?.lowercased().contains(searchTextField.text!.lowercased()))!
                })
           // print("filterArray",filterArray)
            searching = true
            tabelView.reloadData()
        }
    }
}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  print("textFieldBegin",textField.text)
        searching = false
        tabelView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}
