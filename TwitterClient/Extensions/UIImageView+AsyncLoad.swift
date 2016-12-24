//
//  UIImageView+AsyncLoad.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadFrom(urlString: String) {
        let imageURL = URL(string: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: imageURL, options: [.transition(.fade(0.2))])
    }
    
}
