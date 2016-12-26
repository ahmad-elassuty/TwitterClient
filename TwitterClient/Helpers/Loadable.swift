//
//  Loadable.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/26/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


protocol Loadable: class {
    
    var loaderView: LoaderView? { get set }
    var isLoading: Bool { get }
    
    func startLoading()
    func stopLoading()
    
}

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
