//
//  CommunityTableViewCell.swift
//  Hamlet
//
//  Created by admin on 10/21/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leaveButton: UIButton!{
        didSet{
            leaveButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var viewDetailsButton: UIButton!{
        didSet{
            viewDetailsButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var communityBackgroundView: UIView!{
        didSet{
            communityBackgroundView.layer.shadowRadius = 6
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
            communityImage.layer.cornerRadius = 25
            communityImage.clipsToBounds = true
            communityImage.layer.borderWidth = 1.0
            communityImage.layer.borderColor = UIColor.gray.cgColor
        }
    }

    @IBAction func viewDetailsButtonAction(_ sender: Any) {
        completion?()
    }
    
    // MARK: - Variables
    var completion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Internal Functions -
    func viewDetailsAction(completion: @escaping () -> Void) {
        self.completion = completion
    }

}
