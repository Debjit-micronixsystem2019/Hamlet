//
//  ServiceVC.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import MBProgressHUD

class SearchVC: UIViewController {
    
    let datePicker = UIDatePicker()

    // MARK: - IBOutlet
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tabelView : UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var chooseProblemButton: UIButton!
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
              let mainStoryBoard = UIStoryboard(name: "Friend", bundle: nil)
                let vc = mainStoryBoard.instantiateViewController(withIdentifier: "FriendListsVC") as! FriendListsVC
               vc.modalPresentationStyle = .overFullScreen
               self.present(vc, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.segmentedControl.selectedSegmentIndex = 0
            }
        }
        
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.trainerListCommunityService(id: selectProblemID, searchData: self.searchTextField.text ?? "")
    }
    
    @IBAction func chooseProblemButtonAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Search", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "SelectProblemInSearchSectionVC") as! SelectProblemInSearchSectionVC
        vc.modalPresentationStyle = .overFullScreen
        vc.selectProblemID = { (id,problemName) in
           // print("id: ",id)
            self.selectProblemID = id
            self.chooseProblemButton.setTitle(problemName, for: .normal)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var trainerCommunityListVM = TrainerCommunityListViewModel()
    var communityJoinVM = CommunityJoinViewModel()
    var sendFriendRequestVM = SendFriendRequestViewModel()
    var selectProblemID : Int = 0
    lazy var filterArray: [TrainerList] = []
    var searching : Bool = false
    let refreshControl = UIRefreshControl()
    
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
        chooseProblemButton.layer.cornerRadius = 20
        chooseProblemButton.layer.borderWidth = 1
        chooseProblemButton.layer.borderColor = UIColor.lightGray.cgColor
        trainerListCommunityService(id: 0, searchData: "")
        searchTextField.addTarget(self, action: #selector(CoachSearchViewController.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tabelView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        trainerListCommunityService(id: 0, searchData: "")
        refreshControl.endRefreshing()
    }
    
    // MARK: - Request Data To VM From UI
    private func trainerListCommunityService(id : Int , searchData : String) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        trainerCommunityListVM.requestTrainerCommunityList( with: id, searchData: searchData){ [weak self] (result) in
            switch result {
            case .success:
                self?.tabelView.reloadData()
                if let details = self?.trainerCommunityListVM.TrainerCommunityListData{
                    print("Data: ",details.trainers?[7].experties)
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
    
     func communityJoinService(id : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        communityJoinVM.requestCommunityJoin( with: id){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.communityJoinVM.communityJoinData{
                    print("Data: ",details)
                    HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(details.data ?? "")", controller: self!, completion: nil)
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true)}
            }
        }
    }
    
    private func sendFriendequestService(id : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        sendFriendRequestVM.requestSendFriendRequest( with: id){ [weak self] (result) in
            switch result {
            case .success:
                
                HTAlert.showAlertWithTitle(title: AlertConstants.completed, message: "Friend request has been successfully sent!", controller: self!, completion: nil)
                self?.trainerListCommunityService(id: 0, searchData: "")
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
    
    func showFriendRequestConfirmationAlert(id:Int,senderName : String) {
        HTAlert.showAlertWithOptions(title: "Confirmation!", message: "Would you like to send a friend request to \(senderName)", firstButtonTitle: Constants.yes, secondButtonTitle: nil, thirdButtonTitle: nil, controller: self) { (result) in
            if result == Constants.yes {
                self.sendFriendequestService(id : id)
            }
        }
    }
}

extension SearchVC : UITextFieldDelegate{
    
    @objc func textFieldDidChange(textField : UITextField){
        if searchTextField.text?.count == 0{
            searching = false
            tabelView.reloadData()
        }else{
            if self.trainerCommunityListVM.TrainerCommunityListData?.trainers?.count != 0{
            guard let data = self.trainerCommunityListVM.TrainerCommunityListData?.trainers else { return }

              //  NonFilterArray = data.filter({$0.name!.prefix(searchTextField.text!.count) == searchTextField.text!.lowercased()})
                filterArray = data.filter({ (mod) ->Bool in
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
