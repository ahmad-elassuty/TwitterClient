//
//  FollowersViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/23/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    @IBOutlet weak var followersCollectionView: UICollectionView!
    
    weak var navigationTitleView: AccountInfoNavigationTitleView!
    
    var currentAccount: Account! {
        didSet {
            navigationTitleView.configure(withAccount: currentAccount)
        }
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationItems()
        registerCollectionViewCells()
        
        currentAccount = Account.current!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func accountSettings() {
        
    }
    
    // MARK: Private Methods
    private func prepareNavigationItems() {
        // Title View
        navigationTitleView = AccountInfoNavigationTitleView.loadNib()
        navigationItem.titleView = navigationTitleView
        
        // Left Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(accountSettings))
    }
    
    private func registerCollectionViewCells() {
        let cells = [FollowerCollectionViewCell.self]
        cells.forEach { cell in
            let nibName = String(describing: cell)
            let nib     = UINib(nibName: nibName, bundle: nil)
            followersCollectionView.register(nib, forCellWithReuseIdentifier: nibName)
        }
    }
    
}
