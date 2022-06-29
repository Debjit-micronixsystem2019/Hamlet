//
//  ExpertisesListTableViewCell.swift
//  Hamlet
//
//  Created by admin on 11/18/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class ExpertisesListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var selectUnselectButton: UIButton!
    @IBOutlet weak var expertisesNameLabel: UILabel!
    @IBOutlet weak var expertisesDescriptionTextView: UILabel!
    @IBOutlet weak var expertisesImage: UIImageView!{
        didSet{
            expertisesImage.layer.borderWidth = 1.0
            expertisesImage.layer.masksToBounds = false
            expertisesImage.layer.borderColor = UIColor.black.cgColor
            expertisesImage.layer.cornerRadius = expertisesImage.frame.size.width / 2
            expertisesImage.clipsToBounds = true
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
