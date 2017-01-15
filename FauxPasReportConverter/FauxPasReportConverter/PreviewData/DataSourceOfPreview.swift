//
//  PreviewDataSource.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 14/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

public class DataSourceOfPreview: NSViewController, NSCollectionViewDataSource {

 @objc public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return 27
  }

 @objc public func collectionView(_ collectionView: NSCollectionView,
                             itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let item = collectionView.makeItem(withIdentifier: "cell", for: indexPath)
    guard let colectionViewItem = item as? NSCollectionViewItem else {
      return item
    }
    return colectionViewItem
      }

 @objc public func numberOfSections(in collectionView: NSCollectionView) -> Int {
    return 1
  }

}
