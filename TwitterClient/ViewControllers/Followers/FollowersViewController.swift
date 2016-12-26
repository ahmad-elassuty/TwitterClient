//
//  FollowersViewController.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/23/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit
import TwitterKit
import RealmSwift
import Accounts
import NVActivityIndicatorView

class FollowersViewController: BaseViewController {
    
    @IBOutlet weak var followersCollectionView: UICollectionView!
    
    weak var navigationTitleView: AccountInfoNavigationTitleView!
    
    var dataSource      : FollowersDataSource!
    var currentAccount  : Account! {
        didSet {
            navigationTitleView.configure(withAccount: currentAccount)
            dataSource = FollowersDataSource(account: currentAccount)
            dataSource.delegate = self
            followersCollectionView.reloadData()
            dataSource.reloadIfPossible()
        }
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationItems()
        configureCollectionView()
        
        currentAccount = Account.current!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        followersCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if dataSource.isEmpty && dataSource.isFetching {
            startLoading()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.followersCollectionView.performBatchUpdates({
                self?.followersCollectionView.collectionViewLayout.invalidateLayout()
                }, completion: nil)
            }, completion: nil)
    }
    
    // MARK: Methods
    func enableLeftBarButton() {
        navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    func disableLeftBarButton() {
        navigationItem.leftBarButtonItem?.isEnabled = false
    }

    func switchAccounts() {
        let accountStore = ACAccountStore()
        let accountType  = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        guard let userGrantedAccess = accountType?.accessGranted, !userGrantedAccess else {
            let numberOfAccounts = accountStore.accounts(with: accountType).count
            disableLeftBarButton()
            startLoading()
            let method: TWTRLoginMethod = numberOfAccounts == 1 ? .webBased : .systemAccounts
            Twitter.sharedInstance().logIn(withMethods: method, completion: logInCompletion)
            return
        }
        
        let alert = UIAlertController(title: "Grant Access",
                                      message: "Please grant access to Twitter account settings.",
                                      preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Private Methods
    private func configureCollectionView() {
        registerCollectionViewCells()
        addRefreshControl()
        followersCollectionView.backgroundColor = .extraLightGray
    }
    
    private func prepareNavigationItems() {
        // Title View
        navigationTitleView         = AccountInfoNavigationTitleView.loadNib()
        navigationItem.titleView    = navigationTitleView
        
        // Left Item
        let image = UIImage(named: "menu")!.withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(switchAccounts))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func registerCollectionViewCells() {
        let cells: [Any] = [FollowerCollectionViewCell.self, EmptyColletionViewCell.self]
        cells.forEach { cell in
            let nibName = String(describing: cell)
            let nib     = UINib(nibName: nibName, bundle: nil)
            followersCollectionView.register(nib, forCellWithReuseIdentifier: nibName)
        }
    }
    
    private func addRefreshControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        followersCollectionView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        dataSource.reloadIfPossible()
    }
    
}
