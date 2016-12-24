//
//  FollowersNavigationBar.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

class FollowersNavigationBar: UINavigationBar {
    
    var preferredHeight: CGFloat {
        return 80.0
    }
    
    var leftBarButtonWidth: CGFloat {
        return 50
    }
    
    var titleViewWidth: CGFloat {
        return bounds.width - leftBarButtonWidth * 2
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: preferredHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        barTintColor = .main
        tintColor    = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Title View configurations
        topItem?.titleView?.frame.size  = CGSize(width: titleViewWidth, height: bounds.height)
        topItem?.titleView?.center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        // Left Item configurations
        let leftBarButtonView: UIView? = topItem?.leftBarButtonItem?.value(forKey: "view") as? UIView
        leftBarButtonView?.center = CGPoint(x: leftBarButtonWidth/2, y: bounds.midY)
    }
    
}
