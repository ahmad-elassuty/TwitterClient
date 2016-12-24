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
        return ["currentAccountKey", "isCurrentAccount"]
    }
    
}

extension Account {
    
    static var currentAccountKey: String {
        return "currentAccountId"
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
