//
//  TimelineDataSourceDelegate.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import Foundation

protocol TimelineDataSourceDelegate: class {
    
    func dataSourceDidUpdate()
    func dataSource(error: Error)
    
}
