//
//  ServiceVC.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var tabelView : UITableView!
    @IBOutlet weak var tableVWBackView : UIView!
    @IBOutlet weak var searchBarBackView : UIView!
    @IBOutlet weak var datebuttonbackView : UIView!
    @IBOutlet weak var newrequestButton : UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUI()
    }
    
    func setUI(){
        tabelView.tableFooterView = UIView()
        boderShadow(view: tableVWBackView, shadowRadius: 9, shadowOpacity: 0.2, viewcorner: 10)
        submitButton(name: newrequestButton, radiousCorner: 10)
        datebuttonbackView.layer.cornerRadius = 15
        searchBarBackView.layer.cornerRadius = 15
        tableVWBackView.layer.cornerRadius = 20

    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tabelView.dequeueReusableCell(withIdentifier: "ServiceViewCell", for: indexPath) as! SearchViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Service", bundle: nil).instantiateViewController(withIdentifier: "ServiceDetailsController") as? SearchDetailsController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}
