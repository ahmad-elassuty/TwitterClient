//
//  FollowerProfileViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit

class FollowerProfileViewController: UIViewController {

    @IBOutlet weak var tweetsTableView              : UITableView!
    @IBOutlet weak var headerView                   : FollowerProfileHeaderView!
    @IBOutlet weak var headerViewHeightConstraint   : NSLayoutConstraint!
    
    var follower: User!
    var dataSource: TimelineDataSource!
    
    var headerViewHeight: CGFloat {
        return headerViewHeightConstraint.constant
    }
    
    // MARK: Initializers
    convenience init(for follower: User) {
        self.init()
        self.follower = follower
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.configure(with: follower)
        configureTableView()
        dataSource = TimelineDataSource(user: follower)
        dataSource.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Private Methods
    private func configureTableView() {
        let cellIdentifier = String(describing: TWTRTweetTableViewCell.self)
        tweetsTableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tweetsTableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 10, right: 0)
    }
}
