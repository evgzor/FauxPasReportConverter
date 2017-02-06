//
//  ChartCell.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 29/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
import Charts

class ChartCell: NSCollectionViewItem {

  override func viewDidLoad() {
    super.viewDidLoad()

  }
  override func prepareForReuse() {
    super.prepareForReuse()
    guard let chartView = self.view as? BarChartView else {
      return
    }
    chartView.clear()
    chartView.noDataText = ""
  }
  override func awakeFromNib() {
    super.awakeFromNib()

  }

  override func loadView() {

    super.loadView()
  }

}
