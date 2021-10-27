//
//  PostTableViewCell.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var postBackgroundView: UIView!{
        didSet{
            postBackgroundView.layer.shadowRadius = 9
            postBackgroundView.layer.shadowOffset = .zero
            postBackgroundView.layer.shadowOpacity = 0.4
            postBackgroundView.layer.cornerRadius = 10
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
