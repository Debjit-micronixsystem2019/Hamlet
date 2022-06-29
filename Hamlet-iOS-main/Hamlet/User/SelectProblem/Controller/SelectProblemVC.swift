//
//  SelectProblemVC.swift
//  Hamlet
//
//  Created by admin on 10/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class SelectProblemVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBAction
    @IBAction func startButtonAction (_ sender : UIButton) {
      //  navigateToTabView()
        if selectArray == []{
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: Constants.noProblemSelection, controller: self, completion: nil)
        }else{
            selectProblemService(selectArray)
        }
    }
    
    // MARK: - Variables
    var selectArray = [Int]()
    var selectProblemListVM = SelectProblemListViewModel()
    var selectProblemVM = SelectProblemViewModel()
    var fetchSelectedProblemVM = FetchSelectedProblemViewModel()
    var commingFrom = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        selectProblemListService()
        if commingFrom == "menu"{
            startButton.setTitle("Save", for: .normal)
            fetchSelectedProblemListService(userid : AppSettings.shared.userId)
        }else{
            startButton.setTitle("Start", for: .normal)
        }
        tableView.delegate = self
        tableView.dataSource = self
        startButton.layer.cornerRadius = 25
    }
    
    // MARK: - Navigation To Next UI
    func navigateToTabView(){
        let mainStoryBoard = UIStoryboard(name: "TabBar", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    // MARK: - Data Received From VM
    private func selectProblemListService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        selectProblemListVM.requestSelectProblemList{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
               /* if let details = self?.selectProblemListVM.selectProblemResponse {
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
    
    private func fetchSelectedProblemListService(userid : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        fetchSelectedProblemVM.requestForSelectdProblem(with: userid){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.fetchSelectedProblemVM.selectedProblemResponse {
                 print("Data: ",details)
                    self?.selectArray = details.compactMap({$0.id}) as! [Int]
                    //print("selectArray",self?.selectArray)
                 }
                self?.tableView.reloadData()
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
    
    private func selectProblemService(_ problemSelectArray : Array<Int>) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        selectProblemVM.requestSelectProblem(with: problemSelectArray){ [weak self] (result) in
            switch result {
            case .success:
                UserDefaults.standard.setValue(true, forKey: "selectProblemSubmit")
                self?.navigateToTabView()
                /*if let details = self?.selectProblemVM.selectProblemResponse {
                //    print("Data: ",details)
                }*/
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

            }
        }
    }
}

