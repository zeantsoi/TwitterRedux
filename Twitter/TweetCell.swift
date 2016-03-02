//
//  TweetCell.swift
//  Twitter
//
//  Created by Zean Tsoi on 2/22/16.
//  Copyright © 2016 Zean Tsoi. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .None
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5.0

        // Configure the view for the selected state
    }

}
