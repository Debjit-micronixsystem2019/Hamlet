//
//  SearchViewCell.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundView: UIView!{
        didSet{
            cellBackgroundView.layer.shadowRadius = 6
            cellBackgroundView.layer.shadowOffset = .zero
            cellBackgroundView.layer.shadowOpacity = 0.4
            cellBackgroundView.layer.cornerRadius = 24
        }
    }
    @IBOutlet weak var bookButton: UIButton!{
        didSet{
            bookButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var viewDetailsButton: UIButton!{
        didSet{
            viewDetailsButton.layer.cornerRadius = 20
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
