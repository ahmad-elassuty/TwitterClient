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

class LogInViewController: BaseViewController {
    
    @IBOutlet weak var logInButton: TWTRLogInButton!
    
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
    
}
