//
//  TweetComposeViewController.swift
//  Twitter
//
//  Created by Zean Tsoi on 3/2/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

@objc protocol TweetComposeViewControllerDelegate {
    func tweetCompose(tweetComposeViewController: TweetComposeViewController, didSubmit value: Bool)
}

class TweetComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    var user: User!
    var recipientScreenName: String?
    var delegate: TweetComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5.0
        
        profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        nameLabel.text = user.name
        screenNameLabel.text = "@\(user.screenname!)"

        tweetTextView.delegate = self
        
        if recipientScreenName != nil {
            tweetTextView.text = "@\(recipientScreenName!) "
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        let params = NSDictionary(dictionary: ["status": tweetTextView.text])
        TwitterClient.SharedInstance.updateStatusWithParams(params, completion: { (tweet, error) -> () in
            self.dismissViewController()
        })
        self.delegate?.tweetCompose(self, didSubmit: true)
    }
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewController()
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
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
