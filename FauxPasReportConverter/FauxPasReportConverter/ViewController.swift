//
//  ViewController.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 05/07/16.
//  Copyright © 2016 Eugene Zorin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func createExelSheet(sender : AnyObject) -> Void {
        
        let libXl = LibXl.init()
        libXl.createXlSheet()
    }
    
    @IBAction func createXLSheet(sender : AnyObject) -> Void {
        let libxlwriterSheet = Libxlwriter.init()
        libxlwriterSheet.createXlSheet()
    }


}

