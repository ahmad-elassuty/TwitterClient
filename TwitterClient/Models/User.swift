//
//  User.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import ObjectMapper
import RealmSwift

class User: Object, Mappable {
    
    dynamic var id                              = ""
    dynamic var name                            = ""
    dynamic var screenName                      = ""
    dynamic var profileImageURL                 = ""
    dynamic var backgroundImageURL              = ""
    dynamic var bio                 : String?
    dynamic var timeline            : NSData?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id_str"]
        name                <- map["name"]
        screenName          <- map["screen_name"]
        bio                 <- map["description"]
        profileImageURL     <- map["profile_image_url_https"]
        backgroundImageURL  <- map["profile_background_image_url_https"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
