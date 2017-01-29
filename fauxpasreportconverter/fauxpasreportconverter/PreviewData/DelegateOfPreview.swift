//
//  DelegateOfPreview.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 14/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

public class DelegateOfPreview: NSObject, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout {
    let collumsMap = [1, 3, 1]

    public func collectionView(_ collectionView: NSCollectionView,
                               layout collectionViewLayout: NSCollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> NSSize {
        let numberOfColums = collumsMap[indexPath.section]
        var extendCollumMultiplier: CGFloat = 1.0
      var height: CGFloat = 30
      switch (indexPath.item, indexPath.section) {
        case  let (item, section) where item % 3 == 0 && section == 1:
          extendCollumMultiplier = 1.5
        break
        case let (item, section) where (item + 1) % 3 == 0 && section == 1:
         extendCollumMultiplier = 0.5
        break
      case let (_, section) where section == 2:
        height = 200
        break

        default: break

      }

        let width =  extendCollumMultiplier * collectionView.frame.size.width / CGFloat(numberOfColums)
        return NSSize(width: width, height: height)
    }

}
