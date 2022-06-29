//
//  CommunityListSearchSectionCell.swift
//  Hamlet
//
//  Created by admin on 11/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class CommunityListSearchSectionCell: UITableViewCell {

 @IBOutlet weak var cellBackgroundView: UIView!{
   didSet{
       cellBackgroundView.layer.shadowRadius = 6
       cellBackgroundView.layer.shadowOffset = .zero
       cellBackgroundView.layer.shadowOpacity = 0.4
       cellBackgroundView.layer.cornerRadius = 24
       }
   }
  @IBOutlet weak var joinButton: UIButton!{
      didSet{
          joinButton.layer.cornerRadius = 20
      }
  }
  @IBOutlet weak var viewDetailsButton: UIButton!{
      didSet{
          viewDetailsButton.layer.cornerRadius = 20
      }
  }
  @IBOutlet weak var communityNameLabel: UILabel!
  @IBOutlet weak var communityDescriptionLabel: UILabel!
  @IBOutlet weak var totalUserCountLabel: UILabel!
  @IBOutlet weak var communityImageView: UIImageView! {
      didSet{
          communityImageView.layer.cornerRadius = 25
          communityImageView.clipsToBounds = true
          communityImageView.layer.borderWidth = 1.0
          communityImageView.layer.borderColor = UIColor.darkGray.cgColor
      }
  }
    
      override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)

          // Configure the view for the selected state
      }
      

  }


