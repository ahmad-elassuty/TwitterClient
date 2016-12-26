//
//  BaseViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/26/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController, Loadable {
    
    var loaderView  : LoaderView?
    
    // MARK: Methods
    func transition(to viewController: UIViewController, duration: TimeInterval) {
        let window = UIApplication.shared.keyWindow
        UIView.transition(with: window!, duration: duration, options: [.transitionCrossDissolve], animations: {
            UIView.setAnimationsEnabled(false)
            window?.rootViewController = viewController
            UIView.setAnimationsEnabled(true)
            }, completion: nil)
    }
    
}
