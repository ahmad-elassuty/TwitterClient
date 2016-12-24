//
//  FollowersDataSource.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import RealmSwift
import TwitterKit

class FollowersDataSource {
    
    weak var delegate: FollowersDataSourceDelegate?
    
    private var account: Account!
    private var data: List<User>!
    private var notificationToken: NotificationToken!
    
    init(account: Account) {
        set(account: account)
    }
    
    func set(account: Account) {
        self.account = account
        data = account.followers
        notificationToken = data.addNotificationBlock { [weak self] changes in
            switch changes {
            case .error(let error):
                self?.delegate?.dataSource(error: error)
            default:
                self?.delegate?.dataSourceDidUpdate()
            }
        }
    }
    
    subscript(index: Int) -> User {
        return data[index]
    }
    
    func numberOfFollowers() -> Int {
        return data.count
    }
    
    func fetchFollowersIfPossible() {
        let client = TWTRAPIClient(userID: account.id)
        client.followers(ofUserWithID: account.id) { [weak self] followers, error in
            if let followers = followers {
                self?.account.update(followers: followers)
                self?.delegate?.dataSourceDidUpdate()
                return
            }
            
            // Error
            self?.delegate?.dataSource(error: error!)
        }
    }
    
}
