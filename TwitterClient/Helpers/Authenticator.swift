//
//  Authenticator.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit

protocol Authenticator: class {
    
    func authentication(failedWith error: Error)
    func authentication(succeededWith session: TWTRSession)
    
}

extension Authenticator {
    
    var logInCompletion: TWTRLogInCompletion {
        return { [weak self] session, error in
            guard let `self` = self else { return }
            guard let session = session else {
                self.authentication(failedWith: error!)
                return
            }
            self.authentication(succeededWith: session)
        }
    }
    
}
