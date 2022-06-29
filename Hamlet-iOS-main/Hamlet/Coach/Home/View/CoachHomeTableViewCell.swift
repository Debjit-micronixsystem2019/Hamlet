//
//  CoachHomeTableViewCell.swift
//  Hamlet
//
//  Created by admin on 11/2/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class CoachHomeTableViewCell: UITableViewCell {

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
            communityBackgroundView.layer.cornerRadius = 24
        }
    }
    
    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var communityDescription: UILabel!
    @IBOutlet weak var communityMemberCount: UILabel!
    @IBOutlet weak var communityImage: UIImageView!{
        didSet{
            communityImage.roundedImage()
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

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
    }
}
