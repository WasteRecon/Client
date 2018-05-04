//
//  ImagesLayout.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 04/05/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

protocol ImagesLayoutDelegate: class{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class ImagesLayout: UICollectionViewLayout {
    weak var delegate: ImagesLayoutDelegate!
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
}
