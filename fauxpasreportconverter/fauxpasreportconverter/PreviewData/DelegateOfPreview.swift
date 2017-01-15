//
//  DelegateOfPreview.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 14/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

public class DelegateOfPreview: NSObject, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    let collumsMap = [1, 3]
    public func collectionView(_ collectionView: NSCollectionView,
                               layout collectionViewLayout: NSCollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> NSSize {
        let numberOfColums = collumsMap[indexPath.section]
        let width =  collectionView.frame.size.width / CGFloat(numberOfColums)
        return NSSize(width: width, height: 30)
    }

}
