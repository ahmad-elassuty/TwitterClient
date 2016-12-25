//
//  Account.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import RealmSwift
import TwitterKit

class Account: Object {
    
    dynamic var id              = ""
    dynamic var screenName      = ""
    dynamic var profileImageURL = ""
    dynamic var name            = ""
    let followers               = List<User>()
    
    convenience init(twtrUser user: TWTRUser) {
        self.init()
        id              = user.userID
        screenName      = user.screenName
        name            = user.name
        profileImageURL = user.profileImageLargeURL
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["isCurrentAccount", "followersNextCursor"]
    }
    
    // MARK: Methods
    func replaceFollowers(with followers: [User]) {
        let realm = try? Realm()
        try? realm?.write {
            realm?.delete(self.followers)
        }
        // We should always check if the users are
        // already in the database in case two accounts shares
        // same user as a follower
        append(followers: followers)
    }
    
    func append(followers: [User]) {
        let realm = try? Realm()
        try? realm?.write {
            realm?.add(followers, update: true)
            for follower in followers where self.followers.index(of: follower) == nil {
                self.followers.append(follower)
            }
        }
    }
    
    // MARK: Static Methods
    static func createOrUpdate(twtrUser: TWTRUser) -> Account {
        let newAccount = Account(twtrUser: twtrUser)
        let realm = try? Realm()
        
        // We should not invalidate the cached followers
        // on Account update
        guard let existingAccount = Account.find(id: newAccount.id) else {
            try? realm?.write {
                realm?.add(newAccount)
            }
            return newAccount
        }
        
        // Update the account info except the followers
        let values = newAccount.dictionaryWithValues(forKeys: ["id", "name", "screenName", "profileImageURL"])
        try? realm?.write {
            realm?.create(Account.self, value: values, update: true)
        }
        return existingAccount
    }
    
}

extension Account {
    
    static var currentAccountKey: String {
        return "currentAccountId"
    }
    
    var followersNextCursorKey: String {
        return "\(id):" + "followersNextCursor"
    }
    
    var isCurrentAccount: Bool {
        get {
            let currentAccount = UserDefaults.standard.string(forKey: Account.currentAccountKey)
            return currentAccount == id
        }
        set {
            if newValue {
                UserDefaults.standard.set(id, forKey: Account.currentAccountKey)
            }
        }
    }
    
    var followersNextCursor: String {
        get {
            return UserDefaults.standard.string(forKey: followersNextCursorKey) ?? "-1"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: followersNextCursorKey)
        }
    }
    
    static var all: Results<Account>? {
        let realm = try? Realm()
        return realm?.objects(self)
    }
    
    static func find(id: String?) -> Account? {
        guard let id = id else {
            return nil
        }
        return all?.filter("id == %@", id).first
    }
    
    static var current: Account? {
        let currentAccountId = UserDefaults.standard.string(forKey: Account.currentAccountKey)
        return find(id: currentAccountId)
    }
    
    static var count: Int {
        return all?.count ?? 0
    }
    
}
