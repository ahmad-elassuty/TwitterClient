//
//  LogIn+Authenticator.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit
import RealmSwift

extension LogInViewController: Authenticator {
    
    func authentication(failedWith error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            guard let `self` = self else { return }
            self.logInButton.isEnabled = false
            Twitter.sharedInstance().logIn(completion: self.logInCompletion)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { [weak self] _ in
            self?.logInButton.isEnabled = true
        }
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
    
    func authentication(succeededWith session: TWTRSession) {
        logInButton.isEnabled = false
        
        // Fetch user data
        let userID = session.userID
        let client = TWTRAPIClient(userID: userID)
        client.loadUser(withID: userID) { [weak self] user, error in
            guard let user = user else {
                self?.authentication(failedWith: error!)
                return
            }
            
            // Persist the account
            let newAccount = Account.createOrUpdate(twtrUser: user)
            newAccount.isCurrentAccount = true
            
            // Go to FollowersViewController
            let viewController = FollowersNavigationController(navigationBarClass: FollowersNavigationBar.self, toolbarClass: nil)
            self?.transitionTo(viewController: viewController)
        }
    }
    
}
