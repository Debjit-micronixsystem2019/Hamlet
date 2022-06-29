//
//  PostTableViewCell.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!{
        didSet{
            postImageView.layer.cornerRadius = 25
            postImageView.clipsToBounds = true
            postImageView.layer.borderWidth = 1.0
            postImageView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var postBackgroundView: UIView!{
        didSet{
            postBackgroundView.layer.shadowRadius = 6
            postBackgroundView.layer.shadowOffset = .zero
            postBackgroundView.layer.shadowOpacity = 0.4
            postBackgroundView.layer.cornerRadius = 24
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
