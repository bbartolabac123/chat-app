//
//  RightChatTableViewCell.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/12/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import UIKit

class RightChatTableViewCell: UITableViewCell {

    @IBOutlet weak var senderLbl: UILabel!
    @IBOutlet weak var txtView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtView.layer.cornerRadius = 5
        txtView.layer.borderWidth = 0.5
        txtView.backgroundColor = .lightGreen
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
