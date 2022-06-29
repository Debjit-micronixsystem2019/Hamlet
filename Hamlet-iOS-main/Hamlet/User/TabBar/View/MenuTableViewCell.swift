//
//  MenuTableViewCell.swift
//  Hamlet
//
//  Created by admin on 11/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuItemLabel : UILabel!
    @IBOutlet weak var backView : UIView!{
        didSet{
            backView.layer.shadowRadius = 6
            backView.layer.shadowOffset = .zero
            backView.layer.shadowOpacity = 0.4
            backView.layer.cornerRadius = 15
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
