//
//  FeedTableViewCell.swift
//  Turnt
//
//  Created by Darryl Nunn on 4/1/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var goingLabel: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.eventImage.image = nil
        self.userImage.image = nil
        self.usernameLabel.text = ""
        self.goingLabel.text = ""
        
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
