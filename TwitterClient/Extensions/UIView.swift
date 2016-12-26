//
//  UIView.swift
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
    
    
    func pinItemToEdges(item: UIView) {
        item.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutAttribute] = [.top, .bottom, .trailing, .leading]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: item, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: 0)
        })
    }
    
    func centerItem(item: UIView) {
        item.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutAttribute] = [.centerX, .centerY]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: item, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: 0)
        })
    }
}
