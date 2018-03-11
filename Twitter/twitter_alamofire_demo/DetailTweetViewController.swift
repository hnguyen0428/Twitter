//
//  DetailTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hoang on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation
import UIKit

class DetailTweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 240
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTweetCell") as! DetailTweetCell
        cell.tweet = tweet
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            let vc = segue.destination as! TweetViewController
            vc.mode = TweetViewController.REPLY
            vc.tweet = tweet
        }
    }
}
