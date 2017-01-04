//
//  Start.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 03/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
let rtartByteColumn = "byteColumn"
let rtartLine = "line"
let rtartByteOffset = "byteOffset"
let rtartUtf16Column = "utf16Column"
let rtartUtf16Offset = "utf16Offset"
open class Start: NSObject, NSCoding, NSCopying {
  
  var byteColumn: Double?
  var line: Double?
  var byteOffset: Double?
  var utf16Column: Double?
  var utf16Offset: Double?

  override init() {
    super.init()
  }
  
  class func modelObject(withDictionary dict: [AnyHashable: Any]) -> Start {
    return Start.init(dictionary: dict)
  }

  init(dictionary dict: [AnyHashable: Any]) {
    super.init()
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
      self.byteColumn = dict[rtartByteColumn] as? Double
      self.line = dict[rtartLine] as? Double
      self.byteOffset = dict[rtartByteOffset] as? Double
      self.utf16Column = dict[rtartUtf16Column] as? Double
      self.utf16Offset = dict[rtartUtf16Offset] as? Double
  }

  public func dictionaryRepresentation() -> [AnyHashable: Any] {
    var mutableDict = [AnyHashable: Any]()
    mutableDict[rtartByteColumn] = self.byteColumn
    mutableDict[rtartLine] = self.line
    mutableDict[rtartByteOffset] = self.byteOffset
    mutableDict[rtartUtf16Column] = self.utf16Column
    mutableDict[rtartUtf16Offset] = self.utf16Offset
    return mutableDict
  }

  // MARK: - NSCoding Methods
  required public init?(coder aDecoder: NSCoder) {
    super.init()
    self.byteColumn = aDecoder.decodeDouble(forKey: rtartByteColumn)
    self.line = aDecoder.decodeDouble(forKey: rtartLine)
    self.byteOffset = aDecoder.decodeDouble(forKey: rtartByteOffset)
    self.utf16Column = aDecoder.decodeDouble(forKey: rtartUtf16Column)
    self.utf16Offset = aDecoder.decodeDouble(forKey: rtartUtf16Offset)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(byteColumn, forKey: rtartByteColumn)
    aCoder.encode(line, forKey: rtartLine)
    aCoder.encode(byteOffset, forKey: rtartByteOffset)
    aCoder.encode(utf16Column, forKey: rtartUtf16Column)
    aCoder.encode(utf16Offset, forKey: rtartUtf16Offset)
  }

  public func copy(with zone: NSZone?) -> Any {
    let copy = Start.init()
      copy.byteColumn = self.byteColumn
      copy.line = self.line
      copy.byteOffset = self.byteOffset
      copy.utf16Column = self.utf16Column
      copy.utf16Offset = self.utf16Offset
    return copy
  }

}
