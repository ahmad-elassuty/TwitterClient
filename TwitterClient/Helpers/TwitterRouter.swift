//
//  TwitterRouter.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import Foundation

struct TwitterRouter {
    
    private init() {}
    
    static let baseURI = "https://api.twitter.com/1.1/"
    
    static let followersList    = baseURI + "followers/list.json"
    static let timeline         = baseURI + "statuses/user_timeline.json"
    
}
