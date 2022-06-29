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
  /*  @IBOutlet weak var transDelBackView: UIView!{
        didSet{
            transDelBackView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!*/
 //   @IBOutlet weak var bottomConstant: NSLayoutConstraint!

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
   func setMessage(_ chat: GetChatMessageData) {
        messageLabel.text = chat.message
        fromUser.text = chat.user?.name
    timestamp.text = chat.createdAt?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outGoingFormat: "MMM dd yyyy 'at' h:mm a")
    }
    
    func setTranslateMessage(_ chat: String) {
         messageLabel.text = chat
     }
}
