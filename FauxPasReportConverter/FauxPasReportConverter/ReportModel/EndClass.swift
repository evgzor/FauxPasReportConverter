//
//  EndClass.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 03/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
let endClassByteColumn = "byteColumn"
let endClassLine = "line"
let endClassByteOffset = "byteOffset"
let endClassUtf16Column = "utf16Column"
let endClassUtf16Offset = "utf16Offset"
open class EndClass: NSObject, NSCoding, NSCopying {
  var byteColumn: Double = 0.0
  var line: Double = 0.0
  var byteOffset: Double = 0.0
  var utf16Column: Double = 0.0
  var utf16Offset: Double = 0.0
  
  override init() {
    super.init()
  }
  
  class func modelObject(withDictionary dict: [AnyHashable: Any]) -> EndClass {
    return EndClass.init(dictionary: dict)
  }

  init(dictionary dict: [AnyHashable: Any]) {
    super.init()
    // This check serves to mae sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
      self.byteColumn = dict[endClassByteColumn] as? Double ?? 0.0
      self.line = dict[endClassLine] as? Double ?? 0.0
      self.byteOffset = dict[endClassByteOffset] as? Double ?? 0.0
      self.utf16Column = dict[endClassUtf16Column] as? Double ?? 0.0
      self.utf16Offset = dict[endClassUtf16Offset] as? Double ?? 0.0
  }

   func dictionaryRepresentation() -> [AnyHashable: Any] {
    var mutableDict = [AnyHashable: Any]()
    mutableDict[endClassByteColumn] = Int(self.byteColumn)
    mutableDict[endClassLine] = Int(self.line)
    mutableDict[endClassByteOffset] = Int(self.byteOffset)
    mutableDict[endClassUtf16Column] = Int(self.utf16Column)
    mutableDict[endClassUtf16Offset] = Int(self.utf16Offset)
    return mutableDict
  }

  // MARK: - NSCoding Methods
  required public init?(coder aDecoder: NSCoder) {
    super.init()
    self.byteColumn = aDecoder.decodeDouble(forKey: endClassByteColumn)
    self.line = aDecoder.decodeDouble(forKey: endClassLine)
    self.byteOffset = aDecoder.decodeDouble(forKey: endClassByteOffset)
    self.utf16Column = aDecoder.decodeDouble(forKey: endClassUtf16Column)
    self.utf16Offset = aDecoder.decodeDouble(forKey: endClassUtf16Offset)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(byteColumn, forKey: endClassByteColumn)
    aCoder.encode(line, forKey: endClassLine)
    aCoder.encode(byteOffset, forKey: endClassByteOffset)
    aCoder.encode(utf16Column, forKey: endClassUtf16Column)
    aCoder.encode(utf16Offset, forKey: endClassUtf16Offset)
  }

  public func copy(with zone: NSZone? = nil) -> Any {
    let copy = EndClass.init()
      copy.byteColumn = self.byteColumn
      copy.line = self.line
      copy.byteOffset = self.byteOffset
      copy.utf16Column = self.utf16Column
      copy.utf16Offset = self.utf16Offset
    return copy
  }

}
