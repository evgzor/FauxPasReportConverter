//
//  PreviewCollectionView.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 14/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

public class PreviewCollectionView: NSCollectionView {

  fileprivate let dataSourcePreview = DataSourceOfPreview()
  fileprivate let delegatePreview =  DelegateOfPreview()
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.dataSource = dataSourcePreview
    self.delegate = delegatePreview
    
    
    self.register( ItemCell.self, forItemWithIdentifier: "cell")
  }
}
