//
//  TweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hoang on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetViewController: UIViewController, UITextViewDelegate {
    static let TWEET = 0
    static let REPLY = 1
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var charCountBarbutton: UIBarButtonItem!
    
    var mode: Int = TweetViewController.TWEET
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        tweetTextView.text = ""
        
        profileView.layer.cornerRadius = 10.0
        
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
        APIManager.shared.getCurrentAccount { (user, error) in
            if let user = user {
                if let url = user.profileImageUrl {
                    self.profileView.af_setImage(withURL: url)
                }
                
                self.nameLabel.text = user.name
                self.tweetNameLabel.text = user.screenName
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: UIBarButtonItem) {
        if mode == TweetViewController.REPLY {
            APIManager.shared.composeReply(with: tweetTextView.text, tweet: tweet!, completion: { (tweet, error) in
                self.dismiss(animated: true, completion: nil)
            })
        }
        else if mode == TweetViewController.TWEET {
            APIManager.shared.composeTweet(with: tweetTextView.text, completion: { (tweet, error) in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        let remainingChar = characterLimit - newText.characters.count
        charCountBarbutton.title = "\(remainingChar)"
        
        return newText.characters.count < characterLimit
    }
}
