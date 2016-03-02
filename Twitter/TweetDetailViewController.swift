//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Zean Tsoi on 3/2/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
        profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        nameLabel.text = tweet.user!.name
        screenNameLabel.text = "@\(tweet.user!.screenname!)"
        tweetLabel.text = tweet.tweet
        dateLabel.text = formattedDateTime(tweet.createdAt!)
        
        var currentReplyImage = UIImage(named: "reply")
        replyButton.setImage(currentReplyImage, forState: UIControlState.Normal)
        if tweet.user?.screenname == User.currentUser?.screenname {
            replyButton.enabled = false
            retweetButton.enabled = false
        }
        
        if tweet.retweeted == true {
            retweetButton.enabled = false
        }
        
        if tweet.favorited == true {
            starButton.enabled = false
        }

        retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
        starButton.setImage(UIImage(named: "star"), forState: UIControlState.Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
        let storyboard = self.storyboard!
        let tweetComposeViewController = storyboard.instantiateViewControllerWithIdentifier("tweetComposeViewController") as! TweetComposeViewController
        tweetComposeViewController.user = tweet.user!
        tweetComposeViewController.recipientScreenName = tweet.user?.screenname
        self.presentViewController(tweetComposeViewController, animated: true, completion: nil)
    }
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.SharedInstance.retweetStatusWithId(tweet.id_str) { (tweet, error) -> () in
            if tweet != nil {
                self.retweetButton.enabled = false
            }
        }
    }
    @IBAction func onStar(sender: AnyObject) {
        TwitterClient.SharedInstance.createFavoritesWithId(tweet.id_str) { (tweet, error) -> () in
            if tweet != nil {
                self.starButton.enabled = false
            }
        }
        
    }

    
    func formattedDateTime(dateTime: NSDate!) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let dateString = dateFormatter.stringFromDate(dateTime)
        return dateString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
