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
        return dataSource.numberOfTweets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: TWTRTweetTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TWTRTweetTableViewCell
        cell.configure(with: dataSource[indexPath.item])
        return cell
    }
    
}
