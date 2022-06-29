//
//  ProfileTableViewCell.swift
//  Hamlet
//
//  Created by Basir Alam on 25/10/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel : UILabel!
    @IBOutlet weak var itemDescriptionLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
