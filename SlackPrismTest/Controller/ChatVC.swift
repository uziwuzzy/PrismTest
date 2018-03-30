//
//  ChatVC.swift
//  SlackPrismTest
//
//  Created by Muhammad Fauzi Masykur on 3/30/18.
//  Copyright © 2018 Muhammad Fauzi Masykur. All rights reserved.
//

import UIKit
import Alamofire

class ChatVC: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var chatTableView: UITableView!
    var dataArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        let url = URL(string: "http://private-c1e424-elsennov.apiary-mock.com/chats")
        Alamofire.request(url!).responseJSON { (response) in
            //
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let innerDict = dict["data"] {
                    self.dataArray = innerDict as! [AnyObject]
                    self.chatTableView.reloadData()
                    print(self.dataArray)
                }
            }
        }
    }
}
