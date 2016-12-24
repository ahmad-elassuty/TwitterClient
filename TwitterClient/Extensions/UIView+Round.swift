//
//  UIView+Round.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

extension UIView {
    
    func round(withRadius cornerRadius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor? = .clear) {
        layer.borderWidth  = borderWidth
        layer.borderColor  = borderColor?.cgColor
        layer.cornerRadius = cornerRadius
    }
    
}
