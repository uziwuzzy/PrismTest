//
//  ChatTableViewCell.swift
//  SlackPrismTest
//
//  Created by Muhammad Fauzi Masykur on 3/30/18.
//  Copyright © 2018 Muhammad Fauzi Masykur. All rights reserved.
//

import UIKit

//libraries used to show preview
import URLEmbeddedView

//library that combined with URLEmbeddedView to create constraint
import MisterFusion

//library used to detect if label contains url, also can enable url tapping
import ActiveLabel

//used to open safari
import SafariServices

class ChatTableViewCell: UITableViewCell {

    //use activeLabel as class to automatically detect if string contains url, and change the color of it
    @IBOutlet weak var chatLabel: ActiveLabel!
    
    @IBOutlet weak var containerView: UIView!
    
    //initiate embeddedView
    let embeddedView = URLEmbeddedView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //these code below are used to setup the cell view
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        //hide containerView, because there's no data yet, later it can be shown if there's  url.
        containerView.isHidden = true
        
        //setup chatLabel view
        self.chatLabel.URLColor = UIColor(red: 51/255, green: 102/255, blue: 187/255, alpha: 1)
        self.chatLabel.URLSelectedColor = .lightGray
        self.chatLabel.numberOfLines = 0
        
        //add embeddedView to containerView with specified constraint
        containerView.addLayoutSubview(embeddedView, andConstraints:
            embeddedView.top |+| 20,
                                       embeddedView.right |-| 0,
                                       embeddedView.left |+| 0,
                                       embeddedView.bottom |-| 0
        )

    }

}
