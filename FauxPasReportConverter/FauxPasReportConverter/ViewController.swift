//
//  ViewController.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 05/07/16.
//  Copyright © 2016 Eugene Zorin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var reviewCollection: PreviewCollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {

    }
  }

  @IBAction func openFile(_: AnyObject) {
    let dialog = NSOpenPanel()

    dialog.title = "Choose a .txt file"
    dialog.showsResizeIndicator = true
    dialog.showsHiddenFiles = false
    dialog.canChooseDirectories = true
    dialog.canCreateDirectories = true
    dialog.allowsMultipleSelection = false
    dialog.allowedFileTypes = ["txt"]

    if dialog.runModal() == NSModalResponseOK {
      let result = dialog.url // Pathname of the file

      if result != nil {
        let path = result!.path
      }
    } else {
      // User clicked on "Cancel"
      return
    }
  }
  @IBAction func createExelSheet(_: AnyObject) {

    let libXl = LibXl.init()
    libXl.createXlSheet()
  }

  @IBAction func createXLSheet(_: AnyObject) {
    let libxlwriterSheet = Libxlwriter.init()
    self.reviewCollection.setData(dataCollection: libxlwriterSheet.parseDemoMode())
    self.reviewCollection.reloadData()
    
    libxlwriterSheet.createXlSheet()
  }

}

