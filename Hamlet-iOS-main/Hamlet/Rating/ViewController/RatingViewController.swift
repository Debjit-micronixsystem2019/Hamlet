//
//  RatingViewController.swift
//  Hamlet
//
//  Created by admin on 11/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD

class RatingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingBackView: UIView!

    @IBAction func submitButtonAction(_ sender: Any) {
        requestRating(userID: userID, rating : strRating)
    }
    
    @IBAction func dismissViewButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var strRating = 5
    var ratingVM = RatingViewModel()
    var userID = Int()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        ratingView.didTouchCosmos = didTouchCosmos
        ratingView.didFinishTouchingCosmos = didFinishTouchingCosmos
        submitButton.layer.cornerRadius = 20
        ratingBackView.layer.cornerRadius = 20
    }

    private func didTouchCosmos(_ rating: Double) {
        print("touch",Float(rating))
        strRating = Int(rating)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        print("Finish",Int(rating))
    }
    
    private func requestRating(userID: Int, rating : Int) {
        DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        ratingVM.requestRating( with: userID, rating: rating) { [weak self] (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                self?.dismiss(animated: true, completion: nil)
                
            case .failure(let error):
                print(error.description)
                HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                
            }
        }
    }
}
