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
    override func awakeFromNib() {

    }
    override func loadView() {
        //self.view = NSView(frame: NSZeroRect)
        self.view.wantsLayer = true
        self.view.layer = CALayer()
        guard let layer = view.layer else {
            return
        }
        layer.borderWidth = 0.1
        layer.borderColor = .black

    }

}
