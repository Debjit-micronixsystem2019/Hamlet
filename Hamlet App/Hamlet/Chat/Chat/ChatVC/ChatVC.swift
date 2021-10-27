//
//  ChatVC.swift
//  Hamlet
//
//  Created by admin on 10/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class ChatVC: UIViewController {

      //  var jsonFetch = JsonFetchClass()
       // var chat = [Chat]()
        weak var timer: Timer?
        @IBOutlet weak var messageTextView: UITextView!
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var sendButton: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
          //  jsonFetch.jsonData = self
            messageTextView.text = "Type a message"
            messageTextView.textColor = UIColor.lightGray
            registerNib()
          //  getData()
        }
        private func registerNib() {
            tableView.register(UINib.init(nibName: IncomingCell.xibName, bundle: Bundle.appBundle), forCellReuseIdentifier: IncomingCell.identifier)
            tableView.register(UINib.init(nibName: OutgoingCell.xibName, bundle: Bundle.appBundle), forCellReuseIdentifier: OutgoingCell.identifier)
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = false
            startTimer()
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            stopTimer()
        }
        func startTimer() {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { [weak self] _ in
               // self?.getData()
            }
        }
        func stopTimer() {
            timer?.invalidate()
        }
        deinit {
            stopTimer()
        }
        @IBAction func sendMessageButtonAction(_ sender: Any) {
            if messageTextView.text.isEmpty {
                self.view.makeToast("Type something to send" , duration: 2.0, position: .center)
            } else {
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let currentDateTime = dateFormatter.string(from: date)
                print(currentDateTime,"currentdate")
                
              /*  chat.append(
                    Chat(dt: currentDateTime,
                         from_user: "\(UserDefaults.standard.value(forKey: "fullname") ?? "")",
                         id: 0,
                         message: messageTextView?.text,
                         to_user: "\(UserDefaults.standard.value(forKey: "fullname") ?? "")",
                         user_id: UserDefaults.standard.value(forKey: "userid") as? Int)
                )
                sendData(msg: messageTextView.text)
                messageTextView.text = nil
                self.tableView.reloadData()
                if chat.count > 0 {
                    tableView.scrollToRow(at: IndexPath(item:chat.count-1, section: 0), at: .bottom, animated: true)
                }*/
            }
        }
       /* func sendData(msg: String)  {
            let param = [
                "user_id": "\(UserDefaults.standard.value(forKey: "userid") ?? 0)",
                "token": "\(UserDefaults.standard.value(forKey: "token") ?? "")",
                "from_user": "\(UserDefaults.standard.value(forKey: "userid") ?? 0)",
                "message": msg,
                "actiontype": "add_chat"]
            jsonFetch.fetchData(param , methodType: "post", url: BaseUrlPost, JSONName: "add_chat")
            //        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        }
        func getData() {
            let param = [
                "user_id": "\(UserDefaults.standard.value(forKey: "userid") ?? 0)",
                "token": "\(UserDefaults.standard.value(forKey: "token") ?? "")",
                "from_user": "\(UserDefaults.standard.value(forKey: "userid") ?? 0)",
                "actiontype": "get_chat"]
            jsonFetch.fetchData(param , methodType: "post", url: BaseUrlPost, JSONName: "get_chat")
            //        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        }*/
    }

   /* extension ChatVC: jsonDataDelegate {
        func didReceiveData(_ data: Any, jsonName: String) {
            print("Raw Data",data)
            print("jsonname",jsonName)
            if data as? String ==  "NO INTERNET CONNECTION" {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: (self.view)!, animated: true)
                }
                showAlertMessage(alertTitle: "Dr. Maria Ana Marcelo", alertMsg: "No Internet Connection")
            } else {
                do{
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: (self.view)!, animated: true)
                    }
                    if jsonName == "get_chat" {
                        let jsonData = try JSONDecoder().decode(ChatModel.self, from: data as! Data)
                        if jsonData.token == "yes" {
                            self.chat.removeAll()
                            if jsonData.status == "yes" {
                                if jsonData.data?.count ?? 0 > 0{
                                    chat = jsonData.data!
                                    self.tableView.reloadData()
                                    if chat.count > 0 {
                                        tableView.scrollToRow(at: IndexPath(item:chat.count-1, section: 0), at: .bottom, animated: true)
                                    }
                                }
                            }
                        } else {
                            self.logoutMethod()
                        }
                    }
                }catch(let err){
                    print(err.localizedDescription)
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: (self.view)!, animated: true)
                    }
                }
            }
        }
        func didFailedtoReceiveData(_ error: Error) {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: (self.view)!, animated: true)
            }
            showAlert(title: "Error", message: "Something going wrong,try latter", noOfButton: 1)
        }
        func convertToData(givingValue: Any) -> Data? {
            return try? JSONSerialization.data(withJSONObject: givingValue, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
    }*/
    extension ChatVC: UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if messageTextView.textColor == UIColor.lightGray {
                messageTextView.text = nil
                messageTextView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if messageTextView.text.isEmpty {
                messageTextView.text = "Type a message"
                messageTextView.textColor = UIColor.lightGray
            }
        }
    }


// MARK: - TableView Delegates and Datasource
extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     /*   if chat[indexPath.row].from_user == "admin" {
            let cell = setIncomingCell(tableview: tableView, indexPath: indexPath)
            return cell
        } else {*/
            let cell = setOutgoingCell(tableview: tableView, indexPath: indexPath)
            return cell
        //}
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Helper Method for tableview cell for incoming design...
    private func setIncomingCell(tableview: UITableView, indexPath: IndexPath) -> IncomingCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IncomingCell.identifier, for: indexPath) as! IncomingCell
        cell.selectionStyle = .none
      //  cell.setMessage(chat[indexPath.row])
        return cell
    }
    // MARK: - Helper Method for tableview cell for outgoing design...
    private func setOutgoingCell(tableview: UITableView, indexPath: IndexPath) -> OutgoingCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingCell.identifier, for: indexPath) as! OutgoingCell
        cell.selectionStyle = .none
     //   cell.setMessage(chat[indexPath.row])
        return cell
    }
}
