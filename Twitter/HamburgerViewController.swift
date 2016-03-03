//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Zean Tsoi on 3/2/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded() // invoking anything `view` will kick viewDidLoad and instantiate the IBOutlets
            menuViewController.willMoveToParentViewController(self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMoveToParentViewController(self)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded() // invoking anything `view` will kick viewDidLoad and instantiate the IBOutlets
            
            if oldContentViewController != nil {
                oldContentViewController.willMoveToParentViewController(nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMoveToParentViewController(nil)
            }
            
            contentViewController.willMoveToParentViewController(self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMoveToParentViewController(self)
            
            UIView.animateWithDuration(0.3) { () -> Void in
                self.leftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    let MENU_OFFSET = CGFloat(50.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        UIView.animateWithDuration(0.3) { () -> Void in
            if sender.state == UIGestureRecognizerState.Began {
                self.originalLeftMargin = self.leftMarginConstraint.constant
            } else if sender.state == UIGestureRecognizerState.Changed {
                self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x
                
            } else if sender.state == UIGestureRecognizerState.Ended {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - self.MENU_OFFSET
                    
                } else {
                    self.leftMarginConstraint.constant = 0
                }
            }
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
