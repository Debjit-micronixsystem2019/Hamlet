//
//  OutgoingCell.swift
//  DrMariaAnaMarcelo
//
//  Created by Basir Alam on 24/07/20.
//  Copyright © 2020 Arlene Caringal. All rights reserved.
//

import UIKit

class OutgoingCell: UITableViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var fromUser: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Xib and Identifier Create...
    static var xibName: String {
        return String(describing: self.classForCoder())
    }
    static var identifier: String {
        return String(describing: self.classForCoder())
    }
    // MARK: - Cell setup...
  /*  func setMessage(_ chat: Chat) {
        messageLabel.text = chat.message
        fromUser.text = chat.from_user
        timestamp.text = chat.dt
    }*/
}
