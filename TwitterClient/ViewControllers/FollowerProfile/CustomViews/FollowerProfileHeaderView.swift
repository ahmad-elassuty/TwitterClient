//
//  FollowerProfileHeaderView.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

class FollowerProfileHeaderView: UIView {
    
    @IBOutlet weak var profileNameLabel         : UILabel!
    @IBOutlet weak var profileImageView         : UIImageView!
    @IBOutlet weak var backgroundImageView      : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.round(withRadius: 10, borderWidth: 2, borderColor: .white)
    }
    
    func configure(with follower: User) {
        profileNameLabel.text = follower.name
        profileImageView.loadFrom(urlString: follower.profileImageURL)
        backgroundImageView.loadFrom(urlString: follower.backgroundImageURL)
    }

}
