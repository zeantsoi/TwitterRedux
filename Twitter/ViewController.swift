//
//  ViewController.swift
//  Twitter
//
//  Created by Zean Tsoi on 2/20/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.SharedInstance.loginWithCompletion() { (user: User?, error: NSError?) in
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            // TODO: fix this!
            appDelegate.application(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil) // Hack to get login to work...
//            if user != nil {
//                self.performSegueWithIdentifier("hamburgerSegue", sender: self)
//            } else {
//                // handle error
//            }
        }
    }

}

