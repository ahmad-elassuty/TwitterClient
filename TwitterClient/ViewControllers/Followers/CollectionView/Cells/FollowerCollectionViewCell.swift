//
//  FollowerCollectionViewCell.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView     : UIImageView!
    @IBOutlet weak var nameLabel            : UILabel!
    @IBOutlet weak var screenNameLabel      : UILabel!
    @IBOutlet weak var bioLabel             : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        round(withRadius: 10)
        profileImageView.round(withRadius: 10)
    }
    
    func configure(withUser user: User) {
        nameLabel.text          = user.name
        bioLabel.text           = user.bio
        screenNameLabel.text    = "@" + user.screenName
        profileImageView.loadFrom(urlString: user.profileImageURL)
    }
    
    static var minimumHeight: CGFloat {
        let topMargin           : CGFloat = 8
        let bottomMargin        : CGFloat = 8
        let profileImageHeight  : CGFloat = 50
        return topMargin + bottomMargin + profileImageHeight
    }
    
    static var bioFont: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
    }
    
    static func heightThatFits(user: User, width: CGFloat) -> CGFloat {
        var height = minimumHeight
        if let bio = user.bio, !bio.isEmpty {
            height += SizeCalculator.heightThatFits(text: bio, maxWidth: width, font: bioFont)
        }
        return height
    }

}
