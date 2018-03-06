//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
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
            tweetTextLabel.text = tweet.text
            self.favorited = tweet.favorited ?? false
            self.retweeted = tweet.retweeted
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func tappedFavorite(_ sender: UIButton) {
        favorited = !favorited
        
        if favorited {
            APIManager.shared.favorite(tweet, completion: nil)
        }
        else {
            APIManager.shared.unfavorite(tweet, completion: nil)
        }
    }
    
    @IBAction func tappedRetweet(_ sender: UIButton) {
        retweeted = !retweeted
        
        if retweeted {
            APIManager.shared.retweet(tweet, completion: nil)
        }
        else {
            APIManager.shared.unretweet(tweet, completion: nil)
        }
    }
    
    
}
