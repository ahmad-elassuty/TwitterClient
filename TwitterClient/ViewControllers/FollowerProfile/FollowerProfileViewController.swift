//
//  FollowerProfileViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit

class FollowerProfileViewController: BaseViewController {

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
        dataSource          = TimelineDataSource(user: follower)
        dataSource.delegate = self
        headerView.configure(with: follower)
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataSource.reloadIfPossible()
        if dataSource.isEmpty && dataSource.isFetching {
            startLoading()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Actions
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private Methods
    private func configureTableView() {
        tweetsTableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 10, right: 0)
        
        var cellIdentifier = String(describing: TWTRTweetTableViewCell.self)
        tweetsTableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        cellIdentifier  = String(describing: EmptyTableViewCell.self)
        let nib         = UINib(nibName: cellIdentifier, bundle: nil)
        tweetsTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}
