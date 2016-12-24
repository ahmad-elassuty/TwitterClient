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
    
    func replaceFollowers(with followers: [User]) {
        let realm = try? Realm()
        try? realm?.write {
            realm?.delete(self.followers)
            self.followers.removeAll()
            self.followers.append(objectsIn: followers)
        }
    }
    
    func createOrUpdate(followers: [User]) {
        let realm = try? Realm()
        try? realm?.write {
            realm?.add(followers, update: true)
            for follower in followers where self.followers.index(of: follower) == nil {
                self.followers.append(follower)
            }
        }
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
