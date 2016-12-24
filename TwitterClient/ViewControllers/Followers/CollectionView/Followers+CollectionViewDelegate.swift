//
//  Followers+CollectionViewDelegate.swift
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
        // Calculate the height of the bio
        let layout  = collectionViewLayout as! UICollectionViewFlowLayout
        var width   = collectionView.bounds.width - layout.sectionInset.left - layout.sectionInset.right
        
        if UIDevice.current.orientation.isLandscape {
            width /= 2
            width -= layout.minimumInteritemSpacing
        }
        
        let height  = FollowerCollectionViewCell.heightThatFits(user: dataSource[indexPath.item], width: width)
        return CGSize(width: width, height: height)
    }
    
}
