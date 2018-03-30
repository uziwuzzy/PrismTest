//
//  ChatVC.swift
//  SlackPrismTest
//
//  Created by Muhammad Fauzi Masykur on 3/30/18.
//  Copyright © 2018 Muhammad Fauzi Masykur. All rights reserved.
//

import UIKit
import Alamofire
import URLEmbeddedView
import MisterFusion
import ActiveLabel
import SafariServices

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var chatTableView: UITableView!
    var dataArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        
        let eachMessages = self.dataArray[indexPath.section]["message"]
        
        if self.dataArray.count > 0 {
            
            cell.selectionStyle = .none
            cell.chatLabel.text = eachMessages as? String
            
            cell.chatLabel.handleURLTap { url in if #available(iOS 10.0, *) {
                self.present(SFSafariViewController(url: url), animated: true, completion: nil)            } else {
                // Fallback on earlier versions
                cell.chatLabel.handleURLTap { url in UIApplication.shared.openURL(url) }
                }}
            
            var input = eachMessages as? String
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: input!, options: [], range: NSRange(location: 0, length: (input?.utf16.count)!))
            
            for match in matches {
                guard let range = Range(match.range, in: input!) else { continue }
                let url = input![range]
                //                print(input!)
                cell.embeddedView.textProvider[.title].font = .boldSystemFont(ofSize: 8)
                cell.embeddedView.textProvider[.title].fontColor = .lightGray
                cell.embeddedView.textProvider[.title].numberOfLines = 0
                cell.embeddedView.textProvider[.description].numberOfLines = 0
                cell.embeddedView.textProvider[.description].font = .systemFont(ofSize: 10.0)
                cell.embeddedView.loadURL(String(url))
                cell.embeddedView.didTapHandler = { [weak self] embeddedView, URL in
                    guard let URL = URL else { return }
                    self?.present(SFSafariViewController(url: URL), animated: true, completion: nil)
                }
                
                if (input?.contains(url))! {
                    cell.containerView.isHidden = false
                } else {
                    cell.containerView.isHidden = true
                }
                
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight : CGFloat = 0
        let eachMessages = self.dataArray[indexPath.section]["message"]
        var input = eachMessages as? String
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input!, options: [], range: NSRange(location: 0, length: (input?.utf16.count)!))
        
        var url : Substring = ""
        for match in matches {
            guard let range = Range(match.range, in: input!) else { continue }
            url = input![range]
        }
        //        print(url)
        if (input?.contains(url))! {
            rowHeight = 150
        } else {
            rowHeight = 44
        }
        return rowHeight
    }
}
