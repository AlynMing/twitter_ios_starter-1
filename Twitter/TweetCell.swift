//
//  TweetCell.swift
//  Twitter
//
//  Created by Frederick Tetteh on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        var favNum = Int(favoriteLabel.text!) ?? 0
        
        if (tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
                favNum+=1
                self.favoriteLabel.text = String(favNum)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
                favNum-=1
                self.favoriteLabel.text = String(favNum)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        var retweetNum = Int(retweetsLabel.text!) ?? 0
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
            retweetNum+=1
            self.retweetsLabel.text = String(retweetNum)
        }, failure: { (error) in
            print("Error retweeting: \(error)")
        })
    }
    
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)

        }
    }
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
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
