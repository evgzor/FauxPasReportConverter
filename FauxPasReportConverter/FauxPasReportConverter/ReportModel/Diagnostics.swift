//
//  Diagnostics.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 03/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation

let diagnosticsExtent = "extent"
let diagnosticsConfidenceDescription = "confidenceDescription"
let diagnosticsConfidence = "confidence"
let diagnosticsFile = "file"
let diagnosticsRuleDescription = "ruleDescription"
let diagnosticsRuleWarning = "ruleWarning"
let diagnosticsSeverityDescription = "severityDescription"
let diagnosticsContext = "context"
let diagnosticsFileSnippet = "fileSnippet"
let diagnosticsIdentifier = "identifier"
let diagnosticsRuleName = "ruleName"
let diagnosticsImpact = "impact"
let diagnosticsRuleShortName = "ruleShortName"
let diagnosticsSeverity = "severity"
let diagnosticsInfo = "info"
let diagnosticsHtml = "html"

open class Diagnostics: NSObject, NSCoding, NSCopying {
  var extent: Extent?
  var confidenceDescription: String?
  var confidence: Double?
  var file: String?
  var ruleDescription: String?
  var ruleWarning: String?
  var severityDescription: String?
  var context: String?
  var fileSnippet: String?
  var identifier: String?
  var ruleName: String?
  var impact: String?
  var ruleShortName: String?
  var severity: Double?
  var info: String?
  var html: Html?

  class func modelObject(withDictionary dict: [AnyHashable: Any]) -> Diagnostics {
    return Diagnostics.init(dictionary: dict)
  }

  override init() {
    super.init()
  }

  init(dictionary dict: [AnyHashable: Any]) {
    super.init()
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if let diagnosticsExtent = dict[diagnosticsExtent] as? [AnyHashable: Any] {
      self.extent = Extent.modelObject(withDictionary: diagnosticsExtent)
    }
      self.confidenceDescription = dict[diagnosticsConfidenceDescription] as? String
      self.confidence = dict[diagnosticsConfidence] as? Double
      self.file = dict[diagnosticsFile] as? String
      self.ruleDescription = dict[diagnosticsRuleDescription] as? String
      self.ruleWarning = dict[diagnosticsRuleWarning] as? String
      self.severityDescription = dict[diagnosticsSeverityDescription] as? String
      self.context = dict[diagnosticsContext] as? String
      self.fileSnippet = dict[diagnosticsFileSnippet] as? String
      self.identifier = dict[diagnosticsIdentifier] as? String
      self.ruleName = dict[diagnosticsRuleName] as? String
      self.impact = dict[diagnosticsImpact] as? String
      self.ruleShortName = dict[diagnosticsRuleShortName] as? String
      self.severity = dict[diagnosticsSeverity] as? Double
      self.info = dict[diagnosticsInfo] as? String
    if let  diagnosticsHtml =  dict[diagnosticsHtml] as? [AnyHashable: Any] {
      self.html = Html.modelObject(withDictionary: diagnosticsHtml)
    }

  }

  func dictionaryRepresentation() -> [AnyHashable: Any] {
    var mutableDict = [AnyHashable: Any]()
    mutableDict[diagnosticsExtent] = self.extent?.dictionaryRepresentation()
    mutableDict[diagnosticsConfidenceDescription] = self.confidenceDescription
    mutableDict[diagnosticsConfidence] = self.confidence
    mutableDict[diagnosticsFile] = self.file
    mutableDict[diagnosticsRuleDescription] = self.ruleDescription
    mutableDict[diagnosticsRuleWarning] = self.ruleWarning
    mutableDict[diagnosticsSeverityDescription] = self.severityDescription
    mutableDict[diagnosticsContext] = self.context
    mutableDict[diagnosticsFileSnippet] = self.fileSnippet
    mutableDict[diagnosticsIdentifier] = self.identifier
    mutableDict[diagnosticsRuleName] = self.ruleName
    mutableDict[diagnosticsImpact] = self.impact
    mutableDict[diagnosticsRuleShortName] = self.ruleShortName
    mutableDict[diagnosticsSeverity] = Int(self.severity ?? 0.0)
    mutableDict[diagnosticsInfo] = self.info
    mutableDict[diagnosticsHtml] = self.html?.dictionaryRepresentation()
    return mutableDict
  }
  // MARK: - Helper Method

  // MARK: - NSCoding Methods
  required public init?(coder aDecoder: NSCoder) {
    super.init()
    self.extent = aDecoder.decodeObject(forKey: diagnosticsExtent) as? Extent
    self.confidenceDescription = (aDecoder.decodeObject(forKey: diagnosticsConfidenceDescription) as? String) ?? ""
    self.confidence = aDecoder.decodeDouble(forKey: diagnosticsConfidence)
    self.file = (aDecoder.decodeObject(forKey: diagnosticsFile) as? String) ?? ""
    self.ruleDescription = (aDecoder.decodeObject(forKey: diagnosticsRuleDescription) as? String) ?? ""
    self.ruleWarning = (aDecoder.decodeObject(forKey: diagnosticsRuleWarning)  as? String) ?? ""
    self.severityDescription = (aDecoder.decodeObject(forKey: diagnosticsSeverityDescription) as? String) ?? ""
    self.context = (aDecoder.decodeObject(forKey: diagnosticsContext) as? String) ?? ""
    self.fileSnippet = (aDecoder.decodeObject(forKey: diagnosticsFileSnippet) as? String) ?? ""
    self.identifier = (aDecoder.decodeObject(forKey: diagnosticsIdentifier) as? String) ?? ""
    self.ruleName = (aDecoder.decodeObject(forKey: diagnosticsRuleName) as? String) ?? ""
    self.impact = (aDecoder.decodeObject(forKey: diagnosticsImpact) as? String) ?? ""
    self.ruleShortName = (aDecoder.decodeObject(forKey: diagnosticsRuleShortName) as? String) ?? ""
    self.severity = aDecoder.decodeDouble(forKey: diagnosticsSeverity)
    self.info = (aDecoder.decodeObject(forKey: diagnosticsInfo) as? String) ?? ""
    self.html = aDecoder.decodeObject(forKey: diagnosticsHtml) as? Html
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(extent, forKey: diagnosticsExtent)
    aCoder.encode(confidenceDescription, forKey: diagnosticsConfidenceDescription)
    aCoder.encode(confidence, forKey: diagnosticsConfidence)
    aCoder.encode(file, forKey: diagnosticsFile)
    aCoder.encode(ruleDescription, forKey: diagnosticsRuleDescription)
    aCoder.encode(ruleWarning, forKey: diagnosticsRuleWarning)
    aCoder.encode(severityDescription, forKey: diagnosticsSeverityDescription)
    aCoder.encode(context, forKey: diagnosticsContext)
    aCoder.encode(fileSnippet, forKey: diagnosticsFileSnippet)
    aCoder.encode(identifier, forKey: diagnosticsIdentifier)
    aCoder.encode(ruleName, forKey: diagnosticsRuleName)
    aCoder.encode(impact, forKey: diagnosticsImpact)
    aCoder.encode(ruleShortName, forKey: diagnosticsRuleShortName)
    aCoder.encode(severity, forKey: diagnosticsSeverity)
    aCoder.encode(info, forKey: diagnosticsInfo)
    aCoder.encode(html, forKey: diagnosticsHtml)
  }

  public func copy(with zone: NSZone? = nil) -> Any {
    let copy = Diagnostics.init()
    copy.extent = self.extent?.copy(with: zone) as? Extent
    copy.confidenceDescription = self.confidenceDescription
    copy.confidence = self.confidence
    copy.file = self.file
    copy.ruleDescription = self.ruleDescription
    copy.ruleWarning = self.ruleWarning
    copy.severityDescription = self.severityDescription
    copy.context = self.context
    copy.fileSnippet = self.fileSnippet
    copy.identifier = self.identifier
    copy.ruleName = self.ruleName
    copy.impact = self.impact
    copy.ruleShortName = self.ruleShortName
    copy.severity = self.severity
    copy.info = self.info
    copy.html = self.html
    return copy
  }

}
