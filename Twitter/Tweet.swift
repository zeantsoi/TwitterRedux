//
//  Tweet.swift
//  Twitter
//
//  Created by Zean Tsoi on 2/21/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id_str: String?
    var user: User?
    var tweet: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweeted: Bool?
    var favorited: Bool?
    
    init(dictionary: NSDictionary) {
        id_str = dictionary["id_str"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        tweet = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        
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
