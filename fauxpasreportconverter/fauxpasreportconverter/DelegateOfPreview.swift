//
//  DelegateOfPreview.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 14/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

public class DelegateOfPreview: NSObject, NSCollectionViewDelegate,
NSCollectionViewDelegateFlowLayout {
  
    public func collectionView(_ collectionView: NSCollectionView,
                               layout collectionViewLayout: NSCollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> NSSize {
        let width = collectionView.frame.size.width / 3
        return NSSize(width: width, height: 30)
    }
}
