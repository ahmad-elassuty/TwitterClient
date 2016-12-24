//
//  Delegate.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import UIKit

extension FollowersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
}
