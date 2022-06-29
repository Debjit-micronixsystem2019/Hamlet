//
//  CreateCommunityListTableViewCell.swift
//  Hamlet
//
//  Created by admin on 5/20/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import UIKit

class CreateCommunityListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!{
        didSet{
            deleteButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var participateButton: UIButton!{
        didSet{
            participateButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var inviteButton: UIButton!{
        didSet{
            inviteButton.layer.cornerRadius = 20
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

    @IBAction func participateButtonAction(_ sender: Any) {
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

