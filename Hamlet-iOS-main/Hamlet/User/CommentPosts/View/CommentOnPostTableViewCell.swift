//
//  CommentOnPostTableViewCell.swift
//  Hamlet
//
//  Created by admin on 11/10/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import UIKit

class CommentOnPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView : UIImageView!{
        didSet{
            userImageView.roundedImage()
        }
    }
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var commentLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
