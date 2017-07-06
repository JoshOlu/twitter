//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import DateToolsSwift

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    
    
    
    
    
    @IBAction func didTapLike(_ sender: Any) {
        // TODO: Update the local tweet model
        if favoriteButton.isSelected == false {
            favoriteButton.isSelected = true
            tweet.favorited = true
            tweet.favoriteCount += 1
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        } else {
            favoriteButton.isSelected = false
            tweet.favorited = false
            tweet.favoriteCount -= 1
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        }
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        // TODO: Update the local tweet model
        if retweetButton.isSelected == false {
            retweetButton.isSelected = true
            tweet.retweeted = true
            tweet.retweetCount += 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        } else {
            retweetButton.isSelected = false
            tweet.retweeted = false
            tweet.retweetCount -= 1
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        }
    }
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            handleLabel.text = tweet.user.screenName
            timeLabel.text = tweet.createdAtString
            retweetLabel.text = "\(tweet.retweetCount)"
            favoriteLabel.text = "\(tweet.favoriteCount)"
            if tweet.user.imageURL != nil {
                profileImage.af_setImage(withURL: tweet.user.imageURL!)
            }
        }
    }
    
    func refreshData() {
        if tweet.retweetCount == 0 {
            //retweetLabel.text = ""
            retweetLabel.text = "\(tweet.retweetCount)"
        } else {
            retweetLabel.text = "\(tweet.retweetCount)"
        }
        if tweet.favoriteCount == 0 {
            //favoriteLabel.text = ""
            favoriteLabel.text = "\(tweet.favoriteCount)"
        } else {
            favoriteLabel.text = "\(tweet.favoriteCount)"
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
    
}
