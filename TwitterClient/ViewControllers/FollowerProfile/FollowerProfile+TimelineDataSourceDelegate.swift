//
//  FollowerProfile+TimelineDataSourceDelegate.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import Foundation

extension FollowerProfileViewController: TimelineDataSourceDelegate {
    
    func dataSourceDidUpdate() {
        stopLoading()
        tweetsTableView.reloadData()
    }
    
    func dataSource(error: Error) {
        stopLoading()
    }
    
}
