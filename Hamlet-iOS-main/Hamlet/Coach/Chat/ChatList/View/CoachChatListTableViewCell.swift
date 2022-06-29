//
//  CoachChatListTableViewCell.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class CoachChatListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var lastMessageDateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.layer.cornerRadius = 25
            profileImageView.clipsToBounds = true
            profileImageView.layer.borderWidth = 1.0
            profileImageView.layer.borderColor = UIColor.gray.cgColor
        }
    }

    @IBOutlet weak var chatBGView: UIView!{
        didSet{
            chatBGView.layer.shadowRadius = 6
            chatBGView.layer.shadowOffset = .zero
            chatBGView.layer.shadowOpacity = 0.4
            chatBGView.layer.cornerRadius = 16
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
