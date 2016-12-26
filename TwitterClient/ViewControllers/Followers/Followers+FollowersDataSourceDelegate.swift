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
        stopLoading()
        followersCollectionView.refreshControl?.endRefreshing()
        followersCollectionView.reloadData()
    }
    
    func dataSource(error: Error) {
        stopLoading()
        followersCollectionView.refreshControl?.endRefreshing()
    }
    
}
