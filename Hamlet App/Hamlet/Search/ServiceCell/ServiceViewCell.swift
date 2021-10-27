//
//  SearchViewCell.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    
    @IBOutlet weak var moreInfoButton : UIButton!
    @IBOutlet weak var statusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreInfoButton.layer.cornerRadius = 5
        statusButton.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
