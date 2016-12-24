//
//  Followers+FollowersDataSourceDelegate.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import Foundation

extension FollowersViewController: FollowersDataSourceDelegate {
    
    func dataSourceDidUpdate() {
        followersCollectionView.reloadData()
    }
    
    func dataSource(error: Error) {
        print(error.localizedDescription)
    }
    
}
