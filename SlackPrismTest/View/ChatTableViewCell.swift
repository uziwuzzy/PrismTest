//
//  ChatTableViewCell.swift
//  SlackPrismTest
//
//  Created by Muhammad Fauzi Masykur on 3/30/18.
//  Copyright © 2018 Muhammad Fauzi Masykur. All rights reserved.
//

import UIKit
import URLEmbeddedView
import MisterFusion
import ActiveLabel
import SafariServices

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatLabel: ActiveLabel!
    
    @IBOutlet weak var containerView: UIView!
    
    let embeddedView = URLEmbeddedView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        containerView.isHidden = true
        self.chatLabel.URLColor = UIColor(red: 51/255, green: 102/255, blue: 187/255, alpha: 1)
        self.chatLabel.URLSelectedColor = .lightGray
        
        containerView.addLayoutSubview(embeddedView, andConstraints:
            embeddedView.top |+| 20,
                                       embeddedView.right |-| 0,
                                       embeddedView.left |+| 0,
                                       embeddedView.bottom |-| 0
        )

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
