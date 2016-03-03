//
//  MenuViewController.swift
//  Twitter
//
//  Created by Zean Tsoi on 3/2/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var tweetsNavigationController: UINavigationController!
    private var profileViewController: ProfileViewController!
    private var mentionsViewController: MentionsViewController!
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let storyboard = self.storyboard!

        tweetsNavigationController = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController") as! UINavigationController
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        mentionsViewController = storyboard.instantiateViewControllerWithIdentifier("MentionsViewController") as! MentionsViewController
        
        viewControllers.append(tweetsNavigationController)
        viewControllers.append(profileViewController)
        viewControllers.append(mentionsViewController)
        
        hamburgerViewController.contentViewController = tweetsNavigationController

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        let titles = ["Tweets", "Profile", "Mentions"]
        
        cell.menuTitleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
