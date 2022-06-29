//
//  PlanViewController.swift
//  "Hamlet!"
//
//  Created by Basir Alam on 06/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Toast_Swift
import StoreKit
import Alamofire
import MBProgressHUD

class PlanViewController: UIViewController {
    
    @IBOutlet var listTable: UITableView!
    @IBOutlet weak var membershipView: UIView!
    @IBOutlet weak var trialMembershipButton: UIButton!
    @IBOutlet weak var membershipLabel: UILabel!
    @IBOutlet weak var showTrialInfoButton: UIButton!
    let showDetailSegueIdentifier = "showDetail"
    var tid = 0
    var products: [SKProduct] = []
    var isSubscribed = false
    var subscriptionType = "3 days"
    var from = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Plan"
        listTable.tableFooterView = UIView()
        membershipView.isHidden = true
        listTable.isHidden = true
        trialMembershipButton.isHidden = true
        showTrialInfoButton.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(PlanViewController.handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        membershipLabel.layer.cornerRadius = 110
        membershipLabel.clipsToBounds = true
        membershipLabel.layer.borderColor = UIColor.white.cgColor
        membershipLabel.layer.borderWidth = 1.5
        reload()
    }
    @objc func reload() {
        
//        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        
        products = []
        print("count: ",products.count)
        listTable.reloadData()
        
        RazeFaceProducts.store.requestProducts{ [weak self] success, products in
            guard let self = self else { return }
            if success {
                
                self.products = products!
                self.products.sort(by: { (p0, p1) -> Bool in
                    return p0.price.floatValue < p1.price.floatValue
                })
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: (self.view)!, animated: true)
                    self.listTable.reloadData()
                }
            }
            
            //      self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func restoreTapped(_ sender: AnyObject) {
        RazeFaceProducts.store.restorePurchases()
    }
    
    @objc func handlePurchaseNotification(_ notification: Notification) {
        let productDict = notification.object as? [String: Any]
//        savePlanService(months: productDict!["Months"] as! Int)
    }
//    func savePlanService(months: Int) {
//        let cDate = Date.getCurrentDate(dateformat : "yyyy-MM-dd")
//        switch months {
//        case 1:
//            subscriptionType = "3 days"
//        case 2:
//            subscriptionType = "1 month"
//        case 3:
//            subscriptionType = "3 months"
//        case 4:
//            subscriptionType = "Annual"
//        default:
//            subscriptionType = "3 days"
//        }
//        let param = [
//                "actiontype" : "save_user_plan",
//                "user_id": "\(UserDefaults.standard.value(forKey: "UserId") ?? "")",
//                "subscription_type": "\(subscriptionType)",
//                "subscription_date": "\(cDate)",
//                "status": "active",
//        ]
//        print("In app purchase param",param)
//        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
//        jsonFetch.fetchData(param, methodType: "post", url: baseUrl, JSONName: "save_user_plan")
//    }
//    func checkPlanService() {
//        let param = [
//                "actiontype" : "check_plan",
//                "user_id": "\(UserDefaults.standard.value(forKey: "UserId") ?? "")",
//        ]
//        print("param",param)
//        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
//        jsonFetch.fetchData(param, methodType: "post", url: baseUrl, JSONName: "check_plan")
//    }
//    @IBAction func trialButtonAction(_ sender: Any) {
//        if isSubscribed == false {
//            savePlanService(months: 1)
//        } else {
//            listTable.isHidden = false
//            membershipView.isHidden = true
//            trialMembershipButton.isHidden = true
//            showTrialInfoButton.isHidden = true
////            self.view.makeToast("Subscribe from the list" , duration: 3.0, position: .bottom)
//        }
//    }
}

// MARK: - UITableViewDataSource

extension PlanViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
        cell.selectionStyle = .none
        let product = products[(indexPath as NSIndexPath).row]
        cell.product = product
        cell.buyButtonHandler = { product in
            RazeFaceProducts.store.buyProduct(product)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NSMutableAttributedString {
    var fontSize14:CGFloat { return 14 }
    var fontSize:CGFloat { return 18 }
    var boldFont:UIFont { return UIFont(name: "Montserrat-Bold", size: 26) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var boldFont18:UIFont { return UIFont(name: "Montserrat-Bold", size: 18) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFontMedium:UIFont { return UIFont(name: "Montserrat-Medium", size: 16) ?? UIFont.systemFont(ofSize: fontSize)}
    var normalFont:UIFont { return UIFont(name: "Montserrat-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    var normalFont14:UIFont { return UIFont(name: "Montserrat-Regular", size: fontSize14) ?? UIFont.systemFont(ofSize: fontSize14)}

    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    func bold18(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont18
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal16(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFontMedium,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    func normal14(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont14,
        ]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
