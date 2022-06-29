//
//  SelectProblemTableViewCell.swift
//  Hamlet
//
//  Created by admin on 10/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class SelectProblemTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var selectUnselectButton: UIButton!
    @IBOutlet weak var problemNameLabel: UILabel!
    @IBOutlet weak var problemDescriptionTextView: UILabel!
    @IBOutlet weak var problemImage: UIImageView!{
        didSet{
            problemImage.layer.borderWidth = 1.0
            problemImage.layer.masksToBounds = false
            problemImage.layer.borderColor = UIColor.black.cgColor
            problemImage.layer.cornerRadius = problemImage.frame.size.width / 2
            problemImage.clipsToBounds = true
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
