//
//  LayoutPreviewCollectionView.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 15/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

class LayoutPreviewCollectionView: NSCollectionViewFlowLayout {

  override func prepare() {
    super.prepare()
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: NSRect) -> Bool {

    return true
  }

  override func invalidateLayout() {
    super.invalidateLayout()

  }

}
