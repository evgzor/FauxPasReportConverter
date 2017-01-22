//
//  PreviewCollectionView.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 14/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

public class PreviewCollectionView: NSCollectionView, NSWindowDelegate {

  fileprivate let dataSourcePreview = DataSourceOfPreview()
  fileprivate let delegatePreview = DelegateOfPreview()
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.dataSource = dataSourcePreview
    self.delegate = delegatePreview

    NSApplication.shared().windows.first?.delegate = self
  }

  public func setData(dataCollection: ReportModel?) -> Void {

    guard let dataCollection = dataCollection else {
      return
    }
    dataSourcePreview.dataSource = dataCollection
  }

  public func windowDidResize(_ notification: Notification) {
    self.collectionViewLayout?.invalidateLayout()
  }

}
