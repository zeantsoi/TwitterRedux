//
//  Tweet.swift
//  Twitter
//
//  Created by Zean Tsoi on 2/21/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var tweet: String?
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        tweet = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            var tweet = Tweet.init(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets 
    }

}
