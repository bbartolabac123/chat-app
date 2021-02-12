//
//  ChatTableViewCell.swift
//  chatapp
//
//  Created by Diane Malazarte on 2/12/21.
//  Copyright © 2021 Benjamin Bartolabac. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var chatLblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatLblTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var userNameLbl: UILabel!
    
   
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
