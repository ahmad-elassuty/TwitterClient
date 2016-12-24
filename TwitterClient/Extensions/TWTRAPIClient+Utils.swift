//
//  TWTRAPIClient+Utils.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import ObjectMapper
import TwitterKit

extension TWTRAPIClient {
    
    typealias TWTRFollowersCompletion   = ([User]?, String?, Error?) -> ()
    typealias TWTRTimelineCompletion    = (Data?, Error?)   -> ()
    
    func followers(ofUserWithID id: String, limit: Int = 20, nextCursor: String = "-1", completion: @escaping TWTRFollowersCompletion) {
        var error: NSError?
        let count = String(describing: limit)
        let params = ["id": id, "count": count, "skip_status": "true", "cursor": nextCursor]
        
        // Prepare Twitter Request
        let request = urlRequest(withMethod: HTTPMethod.get.rawValue, url: TwitterRouter.followersList, parameters: params, error: &error)
        sendTwitterRequest(request) { (response, data, error) in
            var followers: [User]?
            var nextCursorStr: String?
            
            if let data = data {
                let serializedJSON  = try? JSONSerialization.jsonObject(with: data, options: [])
                let castedJSON      = serializedJSON as? [String: Any]
                let users           = castedJSON?["users"]
                nextCursorStr       = castedJSON?["next_cursor_str"] as? String
                followers           = Mapper<User>().mapArray(JSONObject: users)
            }
            
            completion(followers, nextCursorStr, error)
        }
    }
    
    func timeline(ofUserWithID id: String, limit: Int, completion: @escaping TWTRTimelineCompletion) {
        var error: NSError?
        let count   = String(describing: limit)
        let params  = ["id": id, "count": count]
        
        // Prepare Twitter Request
        let request = urlRequest(withMethod: HTTPMethod.get.rawValue, url: TwitterRouter.timeline, parameters: params, error: &error)
        sendTwitterRequest(request) { (response, data, error) in
            completion(data, error)
        }
    }
    
}
