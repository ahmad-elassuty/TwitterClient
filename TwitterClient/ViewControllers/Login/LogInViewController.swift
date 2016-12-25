//
//  LogInViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/23/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit
import RealmSwift

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInButton: TWTRLogInButton!
    
    var logInCompletion: TWTRLogInCompletion {
        return { [weak self] session, error in
            guard let `self` = self else { return }
            guard let session = session else {
                // LogIn Error
                if let error = error {
                    self.onFailure(error.localizedDescription)
                }
                return
            }
            // LogIn User
            self.onSuccess(session)
        }
    }
    
    // MARK: Overrides
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.logInCompletion = logInCompletion
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Private Methods
    fileprivate func onSuccess(_ session: TWTRSession) {
        logInButton.isEnabled = false
        // Fetch user data
        let userID = session.userID
        let client = TWTRAPIClient(userID: userID)
        client.loadUser(withID: userID) { [weak self] user, error in
            guard let user = user else {
                self?.onFailure(error!.localizedDescription)
                return
            }
            
            // Persist the account
            let newAccount = Account(twtrUser: user)
            let realm = try? Realm()
            try? realm?.write {
                realm?.add(newAccount, update: true)
            }
            newAccount.isCurrentAccount = true
            
            // Go to FollowersViewController
            let viewController = FollowersNavigationController(navigationBarClass: FollowersNavigationBar.self, toolbarClass: nil)
            self?.goTo(viewController: viewController)
        }
    }
    
    fileprivate func onFailure(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error",
                                      message: errorMessage,
                                      preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.logInButton.isEnabled = false
            Twitter.sharedInstance().logIn(completion: self.logInCompletion)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            self.logInButton.isEnabled = true
        }
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func goTo(viewController: UIViewController) {
        let window = UIApplication.shared.keyWindow
        UIView.transition(with: window!, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            UIView.setAnimationsEnabled(false)
            window?.rootViewController = viewController
            UIView.setAnimationsEnabled(true)
            }, completion: nil)
    }
    
}
