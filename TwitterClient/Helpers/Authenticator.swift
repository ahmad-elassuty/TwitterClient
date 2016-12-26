//
//  Authenticator.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import Foundation
import TwitterKit

/**
 Authenticator protocol implements the default handler of twitter authentication callbacks
 and forwards responses to the conforming class.
 */
protocol Authenticator: class {
    
    /**
     This method is called when logIn request fails.
     */
    func authentication(failedWith error: Error)
    
    /**
     This method is called when logIn request succeeds.
     */
    func authentication(succeededWith session: TWTRSession)
    
}

extension Authenticator {
    
    /**
     Default logIn completion handler.
    */
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
