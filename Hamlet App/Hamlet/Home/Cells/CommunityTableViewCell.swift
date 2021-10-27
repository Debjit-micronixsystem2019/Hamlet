//
//  CommunityTableViewCell.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
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
    @IBOutlet weak var communityBackgroundView: UIView!{
        didSet{
            communityBackgroundView.layer.shadowRadius = 9
            communityBackgroundView.layer.shadowOffset = .zero
            communityBackgroundView.layer.shadowOpacity = 0.4
            communityBackgroundView.layer.cornerRadius = 10
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
