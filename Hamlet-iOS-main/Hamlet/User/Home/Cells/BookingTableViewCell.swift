//
//  BookingTableViewCell.swift
//  Hamlet
//
//  Created by Basir Alam on 10/11/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var callButton: UIButton!{
        didSet{
            callButton.layer.cornerRadius = 20
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
    
    @IBOutlet weak var trainerName: UILabel!
    @IBOutlet weak var meetingDescription: UILabel!
    @IBOutlet weak var communityMemberCount: UILabel!
    @IBOutlet weak var trainerImage: UIImageView!{
        didSet{
            trainerImage.layer.cornerRadius = 25
            trainerImage.clipsToBounds = true
            trainerImage.layer.borderWidth = 1.0
            trainerImage.layer.borderColor = UIColor.gray.cgColor
        }
    }

    @IBAction func viewDetailsButtonAction(_ sender: Any) {
        completion?()
    }
    
    @IBOutlet weak var ratingView: CosmosView!

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
