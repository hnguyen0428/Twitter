//
//  MeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hoang on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import AlamofireImage
import UIKit

class MeViewController: UIViewController {
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var profileBackgroundView: UIImageView!
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        profileView.layer.cornerRadius = 10.0
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
        APIManager.shared.getCurrentAccount { (user, error) in
            if let user = user {
                self.user = user
                self.getBanner()
                
                if let url = user.profileImageUrl {
                    self.profileView.af_setImage(withURL: url)
                }
                if let url = user.profileBackgroundImageUrl {
//                    self.profileBackgroundView.af_setImage(withURL: url, completion: { (data) in
//                        if let image = UIImage(data: data.data!) {
//                            let size = image.size
//                            let heightToWidth = size.height / size.width
//                            let newHeight = self.topContainer.frame.width * heightToWidth
//                            self.containerHeightConstraint.constant = newHeight
//                        }
//                    })
                    self.profileBackgroundView.af_setImage(withURL: url)
                }
                
                self.nameLabel.text = user.name
                self.tweetNameLabel.text = user.screenName
                if let count = user.statusesCount {
                    self.tweetsCountLabel.text = "\(count)"
                }
                if let count = user.friendsCount {
                    self.followingsCountLabel.text = "\(count)"
                }
                if let count = user.followersCount {
                    self.followersCountLabel.text = "\(count)"
                }
            }
        }
    }
    
    func getBanner() {
        APIManager.shared.getBanner(userId: user!.id) { (url, error) in
            if let url = url {
                self.profileBackgroundView.af_setImage(withURL: url)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tweetSegue" {
            let vc = segue.destination as! TweetViewController
            vc.mode = TweetViewController.TWEET
        }
    }
}
