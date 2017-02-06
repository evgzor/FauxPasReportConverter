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
    
    var collectionViewItem: NSCollectionViewItem {
      switch indexPath.section {
      case let section where section < 2:
        return collectionView.makeItem(withIdentifier: "ItemCell", for: indexPath)
      case let section where section == 2:
        return collectionView.makeItem(withIdentifier: "ChartCell", for: indexPath)
      default:
        return collectionView.makeItem(withIdentifier: "ItemCell", for: indexPath)
      }
    }

    if let item = collectionViewItem as? ItemCell,
      let textForCell = retriveText(by: indexPath) {
      item.textField?.stringValue = textForCell
      return item
    }

    if let item = collectionViewItem as? ChartCell,
      let chartView = item.view as? BarChartView {
      let values: [Double] = [8, 104, 81, 93, 52, 44, 97, 101, 75, 28,
                              76, 25, 20, 13, 52, 44, 57, 23, 45, 91,
                              99, 14, 84, 48, 40, 71, 106, 41, 45, 61]

      var entries: [ChartDataEntry] = Array()

      for (i, value) in values.enumerated() {
        entries.append(BarChartDataEntry(x: Double(i), y: value))
      }

      let dataSet = BarChartDataSet(values: entries, label: "")
      let data = BarChartData(dataSet: dataSet)
      data.barWidth = 0.85
      chartView.legend.verticalAlignment = .bottom
      chartView.legend.horizontalAlignment = .right
      chartView.chartDescription?.text = "Bug Distribution"
      //chartView.chartDescription?.textAlign = .center
      chartView.leftAxis.axisMinimum = 0.0
      chartView.rightAxis.axisMinimum = 0.0
      chartView.data = data

      return item
    }

    return collectionViewItem
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
