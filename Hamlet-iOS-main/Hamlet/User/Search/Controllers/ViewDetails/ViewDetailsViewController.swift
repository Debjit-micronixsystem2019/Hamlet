//
//  ViewDetailsViewController.swift
//  Hamlet
//
//  Created by admin on 11/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit
import SDWebImage

class ViewDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var ratingView : CosmosView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var descriptionLabelTopConstraint: NSLayoutConstraint!


     // MARK: - Variables
    var trainerData : TrainerList? = nil
    var communityData : CommunityList? = nil
    var comingFrom = ""
     // MARK: - Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         setUI()
     }
    
     func setUI(){
        self.title = "View Details"
        if comingFrom == "Trainer"{
            profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            profileImageView.sd_setImage(with: URL(string:trainerData?.profilePicture ?? ""), placeholderImage: UIImage(named: "noImage"))
            nameLabel.text = trainerData?.name ?? ""
            ratingView.isHidden = false
            descriptionLabelTopConstraint.constant = 60
            descriptionView.isHidden = true
        }else{
            profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            profileImageView.sd_setImage(with: URL(string:communityData?.image ?? ""), placeholderImage: UIImage(named: "noImage"))
            nameLabel.text = communityData?.name ?? ""
            
            ratingView.isHidden = true
            descriptionLabelTopConstraint.constant = 15
            descriptionView.isHidden = false
            descriptionView.text = communityData?.communityDescription

        }
     }
}
