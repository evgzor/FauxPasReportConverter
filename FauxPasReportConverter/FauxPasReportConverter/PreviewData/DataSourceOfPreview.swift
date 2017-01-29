//
//  PreviewDataSource.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 14/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
import Charts

public class DataSourceOfPreview: NSViewController, NSCollectionViewDataSource {
  let map = [1, 12, 1]
  public var dataSource: ReportModel?

  @objc public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {

    return map[section]
  }

  @objc public func collectionView(_ collectionView: NSCollectionView,
                                   itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    var item: NSCollectionViewItem {
      switch indexPath.section {
      case let section where section < 2:
        return collectionView.makeItem(withIdentifier: "ItemCell", for: indexPath)
      case let section where section == 2:
        return collectionView.makeItem(withIdentifier: "ChartCell", for: indexPath)
      default:
        return collectionView.makeItem(withIdentifier: "ItemCell", for: indexPath)
      }
    }

    if let item = item as? ItemCell,
      let textForCell = retriveText(by: indexPath) {
      item.textField?.stringValue = textForCell
    }

    if let item = item as? ChartCell,
      let chartView = item.chartView {
      chartView.noDataText = "You need to provide data for the chart."
    }

    return item
  }

  @objc public func numberOfSections(in collectionView: NSCollectionView) -> Int {
    return map.count
  }

  // MARK: Assosiate data

  func retriveText(by indexPath: IndexPath) -> String? {
    guard let dataSource = self.dataSource,
      let headerlist = self.dataSource?.headerList else {
      return nil
    }

    switch indexPath {
    case IndexPath(item: 0, section: 0):
      return dataSource.projectName
    case IndexPath(item: 0, section: 1) ... IndexPath(item: headerlist.count * 3, section: 1):
      switch indexPath.item {
      case let item where item % 3 == 0:
        return headerlist[indexPath.item / 3].keys.first
      case let item where (item - 1) % 3 == 0:
        return headerlist[(indexPath.item - 1) / 3].values.first ?? ""
      default:
        return ""
      }

    default:
      return "error"
    }
  }

}
