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
    
    private var account             : Account!
    private var data                : List<User>!
    private var nextCursor          : String?
    private var notificationToken   : NotificationToken!
    
    private var fetching            : Bool               = false
    
    var numberOfFollowers: Int {
        return data.count
    }
    
    init(account: Account) {
        set(account: account)
    }
    
    func set(account: Account) {
        self.account    = account
        data            = account.followers
        notificationToken = data.addNotificationBlock { [weak self] changes in
            switch changes {
            case .error(let error):
                self?.delegate?.dataSource(error: error)
            default:
                self?.delegate?.dataSourceDidUpdate()
            }
        }
        nextCursor = account.followersNextCursor
    }
    
    subscript(index: Int) -> User {
        return data[index]
    }
    
    func reloadFollowersIfPossible() {
        fetchFromTwitter { [weak self] followers in
            self?.account.replaceFollowers(with: followers)
        }
    }
    
    func loadNextFollowersPageIfPossible() {
        guard let nextCursor = nextCursor, nextCursor != "0" else {
            return
        }
        fetchFromTwitter(cursor: nextCursor) { [weak self] followers in
            self?.account.createOrUpdate(followers: followers)
        }
    }
    
    private func fetchFromTwitter(cursor: String = "-1", completion: @escaping ([User]) -> ()) {
        let userID = account.id
        let client = TWTRAPIClient(userID: userID)
        fetching = true
        client.followers(ofUserWithID: userID, limit: 4, nextCursor: cursor) { [weak self] followers, nextCursor, error in
            defer {
                self?.fetching = false
            }
            
            guard let `self` = self else {
                return
            }
            
            if let followers = followers {
                completion(followers)
                self.delegate?.dataSourceDidUpdate()
                self.nextCursor = nextCursor!
                self.account.followersNextCursor = nextCursor!
                return
            }
            
            // Error
            self.delegate?.dataSource(error: error!)
        }
    }
    
}
