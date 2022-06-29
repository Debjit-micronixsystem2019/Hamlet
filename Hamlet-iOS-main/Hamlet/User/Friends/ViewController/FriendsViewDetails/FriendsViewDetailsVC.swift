//
//  FriendsViewDetailsVC.swift
//  Hamlet
//
//  Created by admin on 11/16/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class FriendsViewDetailsVC: UIViewController {

    @IBOutlet weak var profileBGView: UIView!{
        didSet{
            profileBGView.layer.shadowRadius = 6
            profileBGView.layer.shadowOffset = .zero
            profileBGView.layer.shadowOpacity = 0.4
            profileBGView.layer.cornerRadius = 24
        }
    }
    @IBOutlet weak var profileImage: UIImageView! {
        didSet{            
            profileImage.layer.borderWidth = 1.0
            profileImage.layer.masksToBounds = false
            profileImage.layer.borderColor = UIColor.black.cgColor
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var giveRatingButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!

    @IBAction func giveRatingButtonAction(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Rating", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        vc.userID = userID
        self.present(vc, animated: true, completion: nil)
    }
    
    var userViewDetailsVM = UserViewDetailsViewModel()
    var userID = Int()
    var comingFrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("comingFrom",comingFrom)
        setUI()
    }
    
    func setUI(){
        giveRatingButton.isHidden = true
        ratingView.isHidden = true
        ratingView.rating = 0
        getProfileData(id: userID)
        self.title = "View Details"
    }

    private func getProfileData(id : Int) {
            DispatchQueue.main.async { MBProgressHUD.showAdded(to: self.view, animated: true) }
        userViewDetailsVM.requestUserViewDetails(with: id){ [weak self] (result) in
                switch result {
                case .success:
                    self?.tableView.reloadData()
                    if let details = self?.userViewDetailsVM.userDetailsResponse {
                        print("Data: ",details)
                        self?.userName.text = details.name ?? ""
                        if details.userTypeID == 2 {
                            self?.giveRatingButton.isHidden = true
                            self?.ratingView.isHidden = true
                        }else{
                          if self?.comingFrom == "friend"{
                            self?.giveRatingButton.isHidden = false
                            self?.ratingView.isHidden = false
                            let rating = Double(details.averageRating ?? "0")
                            self?.ratingView.rating = rating ?? 0
                          }else{
                            self?.giveRatingButton.isHidden = true
                            self?.ratingView.isHidden = true
                            }
                        }
                        
                        /*if self?.comingFrom == "friend"{
                            self?.giveRatingButton.isHidden = false
                        }else{
                            self?.giveRatingButton.isHidden = true
                        }*/
                        
                        self?.profileImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                        self?.profileImage.sd_setImage(with: URL(string:details.profilePicture ?? ""), placeholderImage: UIImage(systemName: "person.circle.fill"))
                    }
                    DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }
                case .failure(let error):
                    print(error.description)
                    HTAlert.showAlertWithTitle(title: AlertConstants.alertTitle, message: "\(error.description)", controller: self!, completion: nil)
                    DispatchQueue.main.async {  MBProgressHUD.hide(for: self!.view, animated: true) }

                }
            }
        }
}


