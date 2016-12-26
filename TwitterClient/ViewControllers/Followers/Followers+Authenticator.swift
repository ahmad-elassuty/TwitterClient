//
//  Followers+Authenticator.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/25/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit
import RealmSwift

extension FollowersViewController: Authenticator {
    
    func authentication(failedWith error: Error) {
        enableLeftBarButton()
        stopLoading()
        
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.switchAccounts()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
    
    func authentication(succeededWith session: TWTRSession) {
        guard session.userID != Account.current!.id else {
            enableLeftBarButton()
            stopLoading()
            return
        }
        
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
            
            // Update the view
            self?.currentAccount = newAccount
            self?.enableLeftBarButton()
            self?.stopLoading()
        }
    }
    
}
