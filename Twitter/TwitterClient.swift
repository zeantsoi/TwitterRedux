//
//  TwitterClient.swift
//  Twitter
//
//  Created by Zean Tsoi on 2/20/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

let twitterConsumerKey = "6q9fiTAyWZ63OjrYFnfEQqlO6"
let twitterConsumerSecret = "foiIR0uCa5fIUAh40oNZiDHeU1RrGxrUtpJUofEt4SL1h5nMV4"
let twitterConsumerBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?

    class var SharedInstance: TwitterClient {
        struct Static {
            static var instance = TwitterClient(baseURL: twitterConsumerBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion

        // fetch request token
        TwitterClient.SharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.SharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("SUCCESSFULLY LOGGED IN")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            
            UIApplication.sharedApplication().openURL(authURL!)
        }, failure: { (error: NSError!) -> Void in
            self.loginCompletion!(user: nil, error: error)
        })
    }
    
    func openURL(url: NSURL!) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            TwitterClient.SharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.SharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print(user)
                self.loginCompletion!(user: user, error: nil)
            }, failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                self.loginCompletion!(user: nil, error: error)
            })
            
            TwitterClient.SharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets {
                    print("text: \(tweet.tweet), createdAt: \(tweet.createdAt)")
                }
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
            })
            
        }) { (error: NSError!) -> Void in
            self.loginCompletion!(user: nil, error: error)
        }
        
    }

}
