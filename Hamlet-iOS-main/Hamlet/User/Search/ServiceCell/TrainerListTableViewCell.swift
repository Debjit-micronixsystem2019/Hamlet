//
//  TrainerListTableViewCell.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class TrainerListTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!{
            didSet{
                cellBackgroundView.layer.shadowRadius = 6
                cellBackgroundView.layer.shadowOffset = .zero
                cellBackgroundView.layer.shadowOpacity = 0.4
                cellBackgroundView.layer.cornerRadius = 24
            }
        }
    @IBOutlet weak var sendFriendRequestButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!{
        didSet{
            bookButton.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var viewDetailsButton: UIButton!{
        didSet{
            viewDetailsButton.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var trainerNameLabel: UILabel!
    @IBOutlet weak var expertiseInLabel: UILabel!
    @IBOutlet weak var trainerDescriptionLabel: UILabel!{
        didSet{
            trainerDescriptionLabel.layer.cornerRadius = 10
            trainerDescriptionLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var trainerImageView: UIImageView! {
        didSet{
            trainerImageView.layer.cornerRadius = 2
            trainerImageView.clipsToBounds = true
            trainerImageView.layer.borderWidth = 1.0
            trainerImageView.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    @IBOutlet weak var ratingView: CosmosView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
