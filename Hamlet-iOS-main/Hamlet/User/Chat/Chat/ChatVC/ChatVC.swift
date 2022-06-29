//
//  ChatVC.swift
//  Hamlet
//
//  Created by admin on 10/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD
import IQKeyboardManager

class ChatVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var translateView: UIView!
    @IBOutlet weak var translateMessageLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - IBAction
    @IBAction func translateViewHideButtonAction(_ sender: Any) {
        translateView.isHidden = true
    }
    @IBAction func sendMessageButtonAction(_ sender: Any) {
        if messageTextView.text == "Type a message" || messageTextView.text.trimmingCharacters(in: .whitespaces).isEmpty{
            self.view.makeToast("Type something to send" , duration: 2.0, position: .bottom)
        } else {
            requestPostChatMessage(message : messageTextView.text ?? "")
            //  stopTimer()
        }
    }
    
    @IBOutlet weak var chatTextBottomConstraint : NSLayoutConstraint!
    
    // MARK: - Variables
    var GetChatMessageVM = GetChatMessageViewModel()
    var postChatMessageVM = PostChatMessageViewModel()
    var translateChatMessageVM = TranslateChatMessageViewModel()
    var chatDeleteMessageVM = ChatDeleteMessageViewModel()
    var friendID = Int()
    weak var timer: Timer?
    var translateArray = [Int]()
    var comingFrom = ""
    var groupName = String()
    
    var chatMessageArray = [GetChatMessageData]()
    var isLoadingMore = false
    
    // MARK: - Variables
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        messageTextView.delegate = self
        messageTextView.text = "Type a message"
        messageTextView.textColor = UIColor.lightGray
        messageTextView.layer.borderWidth = 0.6
        messageTextView.layer.borderColor = UIColor.darkGray.cgColor
        messageTextView.layer.cornerRadius = 7
        messageTextView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 0, right: 0)
        
        registerNib()
        isLoadingMore = false
        requestGetChatMessage(currentPage: 0)
        translateView.layer.borderWidth = 1
        translateView.layer.borderColor = UIColor.darkGray.cgColor
        translateView.layer.cornerRadius = 15
        translateView.layer.shadowRadius = 6
        translateView.layer.shadowOffset = .zero
        translateView.layer.shadowOpacity = 0.4
        translateView.isHidden = true
        self.title = "Chats"
        if comingFrom == "Group"{
            self.CustomButtonAddNavigationBar()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.handleNotification(_:)),
                                               name: .pushNotification,
                                               object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        self.requestGetChatMessage(currentPage: 1)
    }
    
    func CustomButtonAddNavigationBar() {
        let logOUtImage = UIImageView()
        logOUtImage.frame = CGRect(x: 5, y: 5, width: 25, height: 25)
        logOUtImage.image = UIImage(named: "icons8")
        logOUtImage.contentMode = .scaleAspectFit
        
        let moreBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        moreBtn.addSubview(logOUtImage)
        moreBtn.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        moreBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let moreBarBtn = UIBarButtonItem(customView: moreBtn)
        
        navigationItem.setRightBarButtonItems([moreBarBtn], animated: false)
    }
    
    @objc  func didTapLogOutButton(sender: AnyObject){
        let mainStoryBoard = UIStoryboard(name: "CoachChatList", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "GroupChatUserListViewController") as! GroupChatUserListViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.group_id = friendID
        vc.group_name = groupName
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func registerNib() {
        tableView.register(UINib.init(nibName: IncomingCell.xibName, bundle: Bundle.appBundle), forCellReuseIdentifier: IncomingCell.identifier)
        tableView.register(UINib.init(nibName: OutgoingCell.xibName, bundle: Bundle.appBundle), forCellReuseIdentifier: OutgoingCell.identifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        // startTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //  stopTimer()
    }
    
    /*func startTimer() {
     timer?.invalidate()
     timer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { [weak self] _ in
     self?.isLoadingMore = false
     self?.isTimmerHit = true
     self?.requestGetChatMessage(currentPage: 0)
     }
     }
     func stopTimer() {
     timer?.invalidate()
     }
     deinit {
     stopTimer()
     }*/
    
    //MARK:- For minimum chat data
    func keyBoardmove(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if UIDevice.current.name == "iPhone SE" || UIDevice.current.name == "iPhone 8" || UIDevice.current.name == "iPhone 8 Plus"{
                chatTextBottomConstraint.constant = keyboardSize.height
            }else{
                chatTextBottomConstraint.constant = keyboardSize.height - 20
            }
        }
    }
    
    @objc func keyboardHide(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            chatTextBottomConstraint.constant = 0
        }
    }
    
    
    func requestTranslateChatMessage(message : String, message_id : Int, target_lang_id : Int, index : Int) {
        
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        translateChatMessageVM.requestTranslateChatMessage(with: message_id, target_lang_id: target_lang_id){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.translateChatMessageVM.translateChatMessageResponse {
                    //  print("Data: ",details)
                    self?.transelectCell(index: index)
                    
                    /*self?.translateView.isHidden = true
                     self?.translateMessageLabel.text = details.data
                     self?.messageLabel.text = message*/
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
    
    func requestChatDeleteMessage(message_id : Int) {
        
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        chatDeleteMessageVM.requestChatDeleteMessage(with: message_id){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.chatDeleteMessageVM.chatDeleteMessageResponse {
                    print("Data: ",details)
                    self?.isLoadingMore = false
                    self?.requestGetChatMessage(currentPage: 0)
                }
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
    
    func requestGetChatMessage(currentPage :Int) {
        // DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        GetChatMessageVM.requestGetChatMessage(with: "\(friendID)", currentPage: currentPage){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.GetChatMessageVM.GetChatMessageResponse {
                    if details.data?.count ?? 0 <= 4{
                        IQKeyboardManager.shared().isEnabled = false
                       self?.keyBoardmove()
                    }else{
                        IQKeyboardManager.shared().isEnabled = true

                        NotificationCenter.default.removeObserver(self as Any, name: UIResponder.keyboardWillShowNotification, object: nil)
                 //       NotificationCenter.default.removeObserver(self as Any, name: UIResponder.keyboardWillHideNotification, object: nil)
                        
                    }
                    
                    //print("Data: ",details)
                    if self!.isLoadingMore{
                        var tempChatMessageArray = [GetChatMessageData]()
                        tempChatMessageArray = self?.chatMessageArray ?? []
                        self?.chatMessageArray.removeAll()
                        self?.chatMessageArray = details.data! + tempChatMessageArray
                        //  self?.chatMessageArray += details.data ?? []
                    }else{
                        self?.chatMessageArray = details.data ?? []
                        self?.chatMessageArray.reverse()
                        self?.scrollToBottom(chatMessage: details.data ?? [])
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
    
    private func requestPostChatMessage(message : String) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        postChatMessageVM.requestPostChatMessage( with: "\(friendID)", message: message) { [weak self] (result) in
            switch result {
            case .success:
                self?.isLoadingMore = false
                self?.requestGetChatMessage(currentPage: 0)
                self?.messageTextView.text = nil
                //  self?.messageTextView.textColor = UIColor.lightGray
                // self?.startTimer()
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                // self?.startTimer()
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
    
    func scrollToBottom(chatMessage : [GetChatMessageData] = []){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: chatMessage.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ChatVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTextView.textColor == UIColor.lightGray {
            messageTextView.text = nil
            messageTextView.textColor = UIColor.black
          /*  if chatMessageArray.count <= 4{
                IQKeyboardManager.shared().isEnabled = false
                self.keyBoardmove()
            }else{
                IQKeyboardManager.shared().isEnabled = true
            }*/
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text.isEmpty {
            messageTextView.text = "Type a message"
            messageTextView.textColor = UIColor.lightGray
        }
    }
}

