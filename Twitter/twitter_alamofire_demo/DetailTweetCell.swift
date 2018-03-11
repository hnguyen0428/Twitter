//
//  DetailTweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Hoang on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailTweetCell: UITableViewCell {
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited: Bool! {
        didSet {
            tweet.favorited = favorited
            if favorited {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }
            else {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
        }
    }
    
    var retweeted: Bool! {
        didSet {
            tweet.retweeted = retweeted
            if retweeted {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            }
            else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
        }
    }
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user.name
            tweetNameLabel.text = "@\(tweet.user.screenName)"
            tweetLabel.text = tweet.text
            dateLabel.text = tweet.createdAtString
            
            retweetCountLabel.text = "\(tweet.retweetCount)"
            let favoriteCount = tweet.favoriteCount != nil ? "\(tweet.favoriteCount!)" : "0"
            favoriteCountLabel.text = favoriteCount
            favorited = tweet.favorited ?? false
            retweeted = tweet.retweeted
            
            let url = tweet.user.profileImageUrl
            if let url = url {
                print(url)
                profileView.af_setImage(withURL: url)
            }
        }
    }
    
    @IBAction func favorite(_ sender: UIButton) {
        favorited = !favorited
        
        if favorited {
            APIManager.shared.favorite(tweet, completion: nil)
        }
        else {
            APIManager.shared.unfavorite(tweet, completion: nil)
        }
    }
    
    @IBAction func retweet(_ sender: UIButton) {
        retweeted = !retweeted
        
        if retweeted {
            APIManager.shared.retweet(tweet, completion: nil)
        }
        else {
            APIManager.shared.unretweet(tweet, completion: nil)
        }
    }
    
    
}
