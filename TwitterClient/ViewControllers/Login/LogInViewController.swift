//
//  LogInViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/23/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInButton: TWTRLogInButton!
    
    var logInCompletion: TWTRLogInCompletion {
        return { [weak self] session, error in
            guard let `self` = self else { return }
            guard let session = session else {
                // LogIn Error
                if let error = error {
                    self.onFailure(error)
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
        
    }
    
    fileprivate func onFailure(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
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
    
}
