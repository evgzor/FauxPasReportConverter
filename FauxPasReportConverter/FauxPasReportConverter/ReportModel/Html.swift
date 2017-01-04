//
//  Html.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 03/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
let htmlRuleShortName = "ruleShortName"
let htmlInfo = "info"
let htmlRuleDescription = "ruleDescription"
let htmlRuleName = "ruleName"
let htmlRuleWarning = "ruleWarning"
open class Html: NSObject, NSCoding, NSCopying {
  var ruleShortName: String?
  var info: String?
  var ruleDescription: String?
  var ruleName: String?
  var ruleWarning: Any?
  
  override init() {
    super.init()
  }
  
  class func modelObject(withDictionary dict: [AnyHashable: Any]) -> Html {
    return Html.init(dictionary: dict)
  }

  init(dictionary dict: [AnyHashable: Any]) {
    super.init()
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
      self.ruleShortName = dict[htmlInfo] as? String? ?? ""
      self.ruleDescription = dict[htmlRuleDescription] as? String? ?? ""
      self.ruleName = dict[htmlRuleName] as? String? ?? ""
      self.ruleWarning = dict[htmlRuleWarning]
  }

  func dictionaryRepresentation() -> [AnyHashable: Any] {
    var mutableDict = [AnyHashable: Any]()
    mutableDict[htmlRuleShortName] = self.ruleShortName
    mutableDict[htmlInfo] = self.info
    mutableDict[htmlRuleDescription] = self.ruleDescription
    mutableDict[htmlRuleName] = self.ruleName
    mutableDict[htmlRuleWarning] = self.ruleWarning
    return mutableDict
  }

  // MARK: - NSCoding Methods
  required public init?(coder aDecoder: NSCoder) {
    super.init()
    self.ruleShortName = aDecoder.decodeObject(forKey: htmlRuleShortName) as? String? ?? ""
    self.info = aDecoder.decodeObject(forKey: htmlInfo) as? String? ?? ""
    self.ruleDescription = aDecoder.decodeObject(forKey: htmlRuleDescription) as? String? ?? ""
    self.ruleName = aDecoder.decodeObject(forKey: htmlRuleName) as? String? ?? ""
    self.ruleWarning = aDecoder.decodeObject(forKey: htmlRuleWarning) as? String? ?? ""
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(ruleShortName, forKey: htmlRuleShortName)
    aCoder.encode(info, forKey: htmlInfo)
    aCoder.encode(ruleDescription, forKey: htmlRuleDescription)
    aCoder.encode(ruleName, forKey: htmlRuleName)
    aCoder.encode(ruleWarning, forKey: htmlRuleWarning)
  }

  public func copy(with zone: NSZone? = nil) -> Any {
    let copy = Html.init()
      copy.ruleShortName = self.ruleShortName
      copy.info = self.info
      copy.ruleDescription = self.ruleDescription
      copy.ruleName = self.ruleName
      copy.ruleWarning = self.ruleWarning
    return copy
  }

}
