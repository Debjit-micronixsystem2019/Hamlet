//
//  NotificationTableViewCell.swift
//  Hamlet
//
//  Created by Basir Alam on 25/10/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postBackgroundView: UIView!{
        didSet{
            postBackgroundView.layer.shadowRadius = 6
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
