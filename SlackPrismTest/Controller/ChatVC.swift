//
//  ChatVC.swift
//  SlackPrismTest
//
//  Created by Muhammad Fauzi Masykur on 3/30/18.
//  Copyright © 2018 Muhammad Fauzi Masykur. All rights reserved.
//

import UIKit

//library used to do networking, because the url is http, modified info.plist first to allow it
import Alamofire
//libraries used to show preview
import URLEmbeddedView

//library that combined with URLEmbeddedView to create constraint
import MisterFusion

//library used to detect if label contains url, also can enable url tapping
import ActiveLabel

//used to open safari
import SafariServices

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    //initiate model of data
    var dataArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        //add functionalities to hamburgerMenu, it will slide in/out with tap or pan gesture
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //start networking calls to get data from specified url
        let url = URL(string: "http://private-c1e424-elsennov.apiary-mock.com/chats")
        Alamofire.request(url!).responseJSON { (response) in
            //cast data to specified variable
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
    
    //a situational case: using section instead of numberOfRows to show data, so it can adjust height and spacing between cells
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    //used to set spacing between cell.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    //setup headerView as transparent
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    //setup cell at certain row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //setup cell with specified identifier
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        
        //contain the message individual data of message
        let eachMessages = self.dataArray[indexPath.section]["message"]
        
        //error handling if data is nil
        if self.dataArray.count > 0 {
            
            //cell setup
            cell.selectionStyle = .none
            //set label text from received message
            cell.chatLabel.text = eachMessages as? String
            
            //enable tapping url in label based on OS version to open safari
            cell.chatLabel.handleURLTap { url in if #available(iOS 10.0, *) {
                self.present(SFSafariViewController(url: url), animated: true, completion: nil)            } else {
                // Fallback on earlier versions
                cell.chatLabel.handleURLTap { url in UIApplication.shared.openURL(url) }
                }}
            
            //check if string contains url
            var input = eachMessages as? String
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: input!, options: [], range: NSRange(location: 0, length: (input?.utf16.count)!))
            
            //parse url if existed
            for match in matches {
                guard let range = Range(match.range, in: input!) else { continue }
                let url = input![range]
                //                print(input!)
                
                //setup and load embeddedView to show url title and description
                cell.embeddedView.textProvider[.title].font = .boldSystemFont(ofSize: 8)
                cell.embeddedView.textProvider[.title].fontColor = .lightGray
                cell.embeddedView.textProvider[.title].numberOfLines = 0
                cell.embeddedView.textProvider[.description].numberOfLines = 0
                cell.embeddedView.textProvider[.description].font = .systemFont(ofSize: 10.0)
                cell.embeddedView.loadURL(String(url))
                
                //enable tapping the link preview to open safari
                cell.embeddedView.didTapHandler = { [weak self] embeddedView, URL in
                    guard let URL = URL else { return }
                    self?.present(SFSafariViewController(url: URL), animated: true, completion: nil)
                }
                
                //check if data contains url, then specified the state of container view, either hidden or not.
                if (input?.contains(url))! {
                    cell.containerView.isHidden = false
                } else {
                    cell.containerView.isHidden = true
                }
                
            }
            
        }
        return cell
    }
    
    //adjust height of row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight : CGFloat = 0
        
        //check if data contains url
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
        
        //if data contains url, the height is set higher than withour url.
        if (input?.contains(url))! {
            rowHeight = 150
        } else {
            rowHeight = 44
        }
        return rowHeight
    }
}
