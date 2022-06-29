//
//  groupUserListCell.swift
//  Hamlet
//
//  Created by admin on 12/3/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class groupUserListCell: UITableViewCell {

   @IBOutlet weak var username : UILabel!
   @IBOutlet weak var userIdentifyname : UILabel!{
        didSet{
            userIdentifyname.layer.cornerRadius = 10
            userIdentifyname.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var cellBackgroundView: UIView!{
            didSet{
                cellBackgroundView.layer.shadowRadius = 6
                cellBackgroundView.layer.shadowOffset = .zero
                cellBackgroundView.layer.shadowOpacity = 0.4
                cellBackgroundView.layer.cornerRadius = 24
            }
        }
    @IBOutlet weak var removeButton: UIButton!{
        didSet{
            removeButton.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var viewDetailsButton: UIButton!{
        didSet{
            viewDetailsButton.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        }
    }

        override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }

