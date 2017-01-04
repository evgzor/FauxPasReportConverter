//
//  Extent.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 03/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
let extentEnd = "end"
let extentStart = "start"
open class Extent: NSObject, NSCoding, NSCopying {
  
  var endProperty: EndClass?
  var start: Start?
  
  override init() {
    super.init()
  }
  
  class func modelObject(withDictionary dict: [AnyHashable: Any]) -> Extent {
    return Extent.init(dictionary: dict)
  }
  
  init(dictionary dict: [AnyHashable: Any]) {
    super.init()
    // This check serves to mae sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if let endPropertyDic = dict[extentEnd] as? [AnyHashable: Any] {
      self.endProperty = EndClass.modelObject(withDictionary: endPropertyDic)
    }
    if let startDic =  dict[extentStart] as? [AnyHashable: Any] {
      self.start = Start.modelObject(withDictionary: startDic)
    }
  }

  func dictionaryRepresentation() -> [AnyHashable: Any] {
    var mutableDict = [AnyHashable: Any]()
    mutableDict[extentEnd] = self.endProperty?.dictionaryRepresentation()
    mutableDict[extentStart] = self.start?.dictionaryRepresentation()
    return mutableDict
  }

  // MARK: - NSCoding Methods
  required public init?(coder aDecoder: NSCoder) {
    super.init()
    self.endProperty = aDecoder.decodeObject(forKey: extentEnd) as? EndClass
    self.start = aDecoder.decodeObject(forKey: extentStart) as? Start
  }

   public func encode(with aCoder: NSCoder) {
    aCoder.encode(endProperty, forKey: extentEnd)
    aCoder.encode(start, forKey: extentStart)
  }

  public func copy(with zone: NSZone?) -> Any {
    let copy = Extent.init()
      copy.endProperty = self.endProperty?.copy(with: zone) as? EndClass
      copy.start = self.start?.copy(with: zone) as? Start
    return copy
  }

}
