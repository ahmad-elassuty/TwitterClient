//
//  FollowersProfile+TableViewDelegate.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit

extension FollowerProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TWTRTweetTableViewCell.height(for: dataSource[indexPath.item], style: .compact, width: tableView.bounds.width, showingActions: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            let offset = abs(yOffset)
            headerViewHeightConstraint.constant = max(offset, headerView.minHeight)
        }
    }
    
}
