//
//  Loadable.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/26/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

/**
 Loadable protocol handles starting/stopping UIBlocker loader.
 */
protocol Loadable: class {
    
    var loaderView: UIView? { get set }
    var isLoading: Bool { get }
    
    func startLoading()
    func stopLoading()
    
}

// Default implementation for Loadable protocol methods.
extension Loadable where Self: UIViewController {
    
    var isLoading: Bool {
        return loaderView != nil ? true : false
    }
    
    func startLoading() {
        if isLoading {
            return
        }
        
        loaderView = LoaderView(frame: view.bounds)
        view.addSubview(loaderView!)
        view.bringSubview(toFront: loaderView!)
        view.pinItemToEdges(item: loaderView!)
    }
    
    func stopLoading() {
        if isLoading {
            loaderView?.removeFromSuperview()
            loaderView = nil
        }
    }
    
}
