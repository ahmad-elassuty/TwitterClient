//
//  BaseViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/26/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

/**
 BaseViewController is the parent of all TwitterClient view controllers.
 */
class BaseViewController: UIViewController, Loadable {
    var loaderView  : UIView?
    
    // MARK: Methods
    /**
     Transitions between the caller view controller and the given view controller.
     
     This method will set the input view controller as the keyWindow rootViewController.

     - Parameters:
        - to:
            This view controller will be the rootViewController.
        - duration:
            The duration of the transision animation.
     */
    func transition(to viewController: UIViewController, duration: TimeInterval) {
        let window = UIApplication.shared.keyWindow
        UIView.transition(with: window!, duration: duration, options: [.transitionCrossDissolve], animations: {
            UIView.setAnimationsEnabled(false)
            window?.rootViewController = viewController
            UIView.setAnimationsEnabled(true)
            }, completion: nil)
    }
    
}
