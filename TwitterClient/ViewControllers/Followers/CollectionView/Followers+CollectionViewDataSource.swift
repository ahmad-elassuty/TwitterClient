//
//  Followers+CollectionViewDataSource.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

extension FollowersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource.isEmpty {
            return 1
        }
        
        return dataSource.numberOfFollowers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !dataSource.isEmpty else {
            let cellIdentifier  = String(describing: EmptyColletionViewCell.self)
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EmptyColletionViewCell
            return cell
        }
        
        let cellIdentifier  = String(describing: FollowerCollectionViewCell.self)
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FollowerCollectionViewCell
        cell.configure(withUser: dataSource[indexPath.item])
        
        UIView.performWithoutAnimation {
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
}
