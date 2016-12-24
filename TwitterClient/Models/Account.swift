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
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
