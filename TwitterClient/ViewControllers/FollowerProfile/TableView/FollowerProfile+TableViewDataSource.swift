//
//  FollowerProfile+TableViewDataSource.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit

extension FollowerProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty && !dataSource.isFetching {
            return 1
        }
        
        return dataSource.numberOfTweets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !dataSource.isEmpty else {
            let cellIdentifier = String(describing: EmptyTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! EmptyTableViewCell
            return cell
        }
        
        let cellIdentifier = String(describing: TWTRTweetTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TWTRTweetTableViewCell
        cell.configure(with: dataSource[indexPath.item])
        return cell
    }
    
}
