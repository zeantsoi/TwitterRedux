//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Zean Tsoi on 2/21/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        TwitterClient.SharedInstance.homeTimelineWithParams(nil) { (tweetObjects, error) -> () in
            self.tweets = tweetObjects
            for tweet in self.tweets! {
                print(tweet.tweet)
            }
            self.tableView.reloadData()
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweetLabel.text = tweets![indexPath.row].tweet as String!
        cell.usernameLabel.text = tweets![indexPath.row].user!.name as String!
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tweets)
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
        
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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
