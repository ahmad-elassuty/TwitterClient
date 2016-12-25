//
//  FollowerProfileViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

class FollowerProfileViewController: UIViewController {

    @IBOutlet weak var tweetsTableView              : UITableView!
    @IBOutlet weak var headerView                   : FollowerProfileHeaderView!
    @IBOutlet weak var headerViewHeightConstraint   : NSLayoutConstraint!
    
    var follower: User!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private Methods
    private func configureTableView() {
        tweetsTableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 8, bottom: 10, right: 8)
    }
}
