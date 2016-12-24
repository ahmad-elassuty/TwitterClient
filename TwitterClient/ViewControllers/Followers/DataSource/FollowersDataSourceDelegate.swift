//
//  FollowersDataSourceDelegate.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import Foundation

protocol FollowersDataSourceDelegate: class {
    
    func dataSourceDidUpdate()
    func dataSource(error: Error)
    
}
