//
//  ViewOfItemCell.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 15/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

class ViewOfItemCell: NSView {

    override var wantsUpdateLayer: Bool {
        return true
    }

    override func updateLayer() {
        self.layer?.borderColor = .black
        self.layer?.borderWidth = 0.1
    }
    override func awakeFromNib() {
        print("")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

}
