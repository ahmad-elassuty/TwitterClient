//
//  FollowersProfile+TableViewDelegate.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

extension FollowerProfileViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            let offset = abs(yOffset)
            headerViewHeightConstraint.constant = max(offset, headerView.minHeight)
        }
    }
    
}
