//
//  GroupChatUserListTableViewCell.swift
//  Hamlet
//
//  Created by admin on 11/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class GroupChatUserListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var selectUnselectButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var countryname : UILabel!
    @IBOutlet weak var userIdentifyname : UILabel!{
         didSet{
             userIdentifyname.layer.cornerRadius = 10
             userIdentifyname.layer.masksToBounds = true
         }
     }

    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.layer.borderWidth = 1.0
            userImage.layer.masksToBounds = false
            userImage.layer.borderColor = UIColor.black.cgColor
            userImage.layer.cornerRadius = userImage.frame.size.width / 2
            userImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.shadowRadius = 6
            backView.layer.shadowOffset = .zero
            backView.layer.shadowOpacity = 0.4
            backView.layer.cornerRadius = 16
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
