//
//  AllFriendsListTableViewCell.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class AllFriendsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var cellBackgroundView: UIView!{
        didSet{
            cellBackgroundView.layer.shadowRadius = 6
            cellBackgroundView.layer.shadowOffset = .zero
            cellBackgroundView.layer.shadowOpacity = 0.4
            cellBackgroundView.layer.cornerRadius = 24
        }
    }
     @IBOutlet weak var viewDetailsButton: UIButton!{
         didSet{
             viewDetailsButton.layer.cornerRadius = 15
         }
     }
     @IBOutlet weak var userNameRatingView: CosmosView!
     @IBOutlet weak var userNameLabel: UILabel!
     @IBOutlet weak var userDescriptionLabel: UILabel!
     @IBOutlet weak var userIdentityLabel: UILabel!{
        didSet{
            userIdentityLabel.layer.cornerRadius = 10
            userIdentityLabel.layer.masksToBounds = true
        }
    }
     @IBOutlet weak var userImageView: UIImageView! {
         didSet{
             userImageView.layer.cornerRadius = 25
             userImageView.clipsToBounds = true
             userImageView.layer.borderWidth = 1.0
             userImageView.layer.borderColor = UIColor.darkGray.cgColor
         }
     }
   @IBOutlet weak var bottomConstant: NSLayoutConstraint!

     
     override func awakeFromNib() {
         super.awakeFromNib()
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)

     }

 }

