//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Zean Tsoi on 2/21/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetComposeViewControllerDelegate {


    @IBOutlet weak var tableView: UITableView!

    let titleString: String! = "Tweets"
    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        // Do any additional setup after loading the view.
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweetLabel.text = tweets![indexPath.row].tweet as String!
        cell.usernameLabel.text = tweets![indexPath.row].user!.name as String!
        cell.timeLabel.text = timeAgoSinceDate(tweets![indexPath.row].createdAt!)
//        cell.screenNameLabel.text = "@\(tweets![indexPath.row].user!.screenname!)"
        let profileImageUrl = NSURL(string: tweets![indexPath.row].user!.profileImageUrl!)
cell.profileImageView.setImageWithURL(profileImageUrl!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender is UIBarButtonItem {
            let tweetComposeViewController = segue.destinationViewController as! TweetComposeViewController
            tweetComposeViewController.user = User.currentUser!
            tweetComposeViewController.delegate = self
        } else {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            
            let tweet = tweets![indexPath!.row]
            
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        }
        
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func refreshControlAction(sender: UIRefreshControl!) {
        loadData()
        sender.endRefreshing()
    }

    func loadData() {
        TwitterClient.SharedInstance.homeTimelineWithParams(nil) { (tweetObjects, error) -> () in
            self.tweets = tweetObjects
            self.tableView.reloadData()
        }
    }
    
    func tweetCompose(tweetComposeViewController: TweetComposeViewController, didSubmit value: Bool) {
        if value == true {
            loadData()
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

    // Source: https://gist.github.com/jacks205/4a77fb1703632eb9ae79
    func timeAgoSinceDate(date:NSDate, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.day >= 1){
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            
            let dateString = dateFormatter.stringFromDate(date)
            return dateString
        } else if (components.hour >= 2) {
            return "\(components.hour) hours ago"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute) minutes ago"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second) seconds ago"
        } else {
            return "Just now"
        }
        
    }
}
