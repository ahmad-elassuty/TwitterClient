//
//  TimelineDataSource.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import Foundation
import TwitterKit
import RealmSwift

class TimelineDataSource {
    
    weak var delegate: TimelineDataSourceDelegate?
    
    private var user: User
    private var data: [TWTRTweet] {
        didSet {
            delegate?.dataSourceDidUpdate()
        }
    }
    
    var numberOfTweets: Int {
        return data.count
    }
    
    init(user: User) {
        self.user = user
        data = []
        data = serializeUser(timeline: user.timeline) ?? data
        reloadTimelineIfPossible()
    }
    
    subscript(index: Int) -> TWTRTweet {
        return data[index]
    }
    
    private func serializeUser(timeline: Data?) -> [TWTRTweet]? {
        if let timeline = timeline {
            let json        = try? JSONSerialization.jsonObject(with: timeline, options: [])
            let JSONArray  = json as? [Any]
            return TWTRTweet.tweets(withJSONArray: JSONArray) as? [TWTRTweet]
        }
        return nil
    }
    
    private func reloadTimelineIfPossible() {
        let client = TWTRAPIClient(userID: Account.current!.id)
        client.loadTimeline(ofUserWithID: user.id, count: "10") { [weak self] (timeline, error) in
            // Serialize received timeline
            guard let `self` = self else {
                return
            }
            
            guard let timeline = timeline, let serializedTimeline = self.serializeUser(timeline: timeline) else {
                // Error
                if let error = error {
                    self.delegate?.dataSource(error: error)
                }
                return
            }
            
            // Update user cached timeline
            let realm = try? Realm()
            try? realm?.write {
                self.user.timeline = timeline
            }
            
            // Update view data
            self.data = serializedTimeline
        }
    }
    
}
