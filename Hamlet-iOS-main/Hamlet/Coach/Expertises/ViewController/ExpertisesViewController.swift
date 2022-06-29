//
//  ExpertisesViewController.swift
//  Hamlet
//
//  Created by admin on 11/18/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class ExpertisesViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBAction
    @IBAction func startButtonAction (_ sender : UIButton) {
        //  navigateToTabView()
        if selectArray == []{
            HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: Constants.noExpertiseSelection, controller: self, completion: nil)
        }else{
           selectExpertisesService(selectArray)
          //  navigateToTabView()
        }
    }
    
    // MARK: - Variables
    var selectArray = [Int]()
    var expertisesListVM = ExpertisesListViewModel()
    var selectExpertisesVM = SelectExpertisesViewModel()
    var fetchSelectedExpertisesListVM = FetchSelectedExpertisesListViewModel()
    var comingFrom = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        startButton.layer.cornerRadius = 25
        expertisesListService()
        if comingFrom == "EditExpertise"{
            startButton.setTitle("Save", for: .normal)
            fetchExpertisesListService(userid : AppSettings.shared.userId)
        }else{
            startButton.setTitle("Start", for: .normal)
        }
    }
    
    // MARK: - Navigation To Next UI
    func navigateToTabView(){
        let mainStoryBoard = UIStoryboard(name: "CoachTabBar", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "CoachTabBarController") as! CoachTabBarController
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
    // MARK: - Data Received From VM
    private func expertisesListService() {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        expertisesListVM.requestExpertisesList{ [weak self] (result) in
            switch result {
            case .success:
                self?.tableView.reloadData()
                /* if let details = self?.expertisesListVM.selectProblemResponse {
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
    
    private func fetchExpertisesListService(userid : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        fetchSelectedExpertisesListVM.requestSelectedExpertisesList(with: userid){ [weak self] (result) in
            switch result {
            case .success:
                if let details = self?.fetchSelectedExpertisesListVM.fetchExpertisesListResponse {
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
    
    private func selectExpertisesService(_ SelectExpertisesArray : Array<Int>) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        selectExpertisesVM.requestSelectExpertises(with: SelectExpertisesArray){ [weak self] (result) in
            switch result {
            case .success:
                if self?.comingFrom == "EditExpertise"{
                    self?.editExpertiseSucessAlert()
                }else{
                UserDefaults.standard.setValue(true, forKey: "selectExpertisesSubmit")
                self?.navigateToTabView()
                }
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
    
    func editExpertiseSucessAlert() {
           let alertController = UIAlertController(title: "Successfully!", message: "Expertises saved successfully", preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
}


