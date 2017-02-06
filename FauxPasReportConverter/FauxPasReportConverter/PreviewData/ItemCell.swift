//
//  ItemCell.swift
//
//
//  Created by Eugene Zorin on 14/01/2017.
//
//

import Foundation

class ItemCell: NSCollectionViewItem {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func prepareForReuse() {
    self.textField?.stringValue = ""
  }

  override func awakeFromNib() {
    super.awakeFromNib()

  }

  override func loadView() {

    super.loadView()
  }

}
