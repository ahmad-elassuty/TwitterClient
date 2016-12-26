//
//  LoaderView.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/26/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let color   = UIColor.white
        let padding = (frame.width - 50) / 2
        let type    = NVActivityIndicatorType.ballClipRotate
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                            type: type,
                                                            color: color,
                                                            padding: padding)
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
        centerItem(item: activityIndicatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
