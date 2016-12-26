//
//  AccountInfoNavigationTitleView.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

class AccountInfoNavigationTitleView: UIView {

    @IBOutlet weak var profileImageView             : UIImageView!
    @IBOutlet weak var userNameLabel                : UILabel!
    @IBOutlet weak var profileImageWidthConstraint  : NSLayoutConstraint!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.round(withRadius: profileImageWidthConstraint.constant/2,
                               borderWidth: 2, borderColor: .white)
    }
    
    // MARK: Methods
    func configure(withAccount account: Account) {
        userNameLabel.text = account.name
        profileImageView.loadFrom(urlString: account.profileImageURL)
    }
    
    // MARK: Class Methods
    class func loadNib() -> AccountInfoNavigationTitleView {
        let nibName = String(describing: self)
        let nibView = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        return nibView!.first as! AccountInfoNavigationTitleView
    }
}
