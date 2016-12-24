//
//  FollowersViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/23/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    @IBOutlet weak var followersCollectionView: UICollectionView!
    
    weak var navigationTitleView: AccountInfoNavigationTitleView!
    
    // MARK: Overrides    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func accountSettings() {
        
    }
    
    // MARK: Private Methods
    private func prepareNavigationItems() {        
        // Title View
        navigationTitleView      = AccountInfoNavigationTitleView.loadNib()
        navigationItem.titleView = navigationTitleView
        
        // Left Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(accountSettings))
    }
}
