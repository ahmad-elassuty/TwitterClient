//
//  RealmObject+Utils.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import RealmSwift

extension Object {
    
    static func performWithWriteTransaction(code: @escaping (Realm?) -> ()) throws {
        do {
            let realm = try Realm()
            try realm.write {
                code(realm)
            }
        } catch let error {
            throw error
        }
    }
    
    func save(update: Bool = true) throws {
        try Object.performWithWriteTransaction { realm in
            realm?.add(self, update: update)
        }
    }
    
}
