//
//  ReportModel.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 03/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
//  Converted with Swiftify v1.0.6198 - https://objectivec2swift.com/
//
//  ReportModel.m
//
//  Created by Evgeny Zorin on 03/01/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//
let reportModelBuildConfigurationName = "buildConfigurationName"
let reportModelFauxPasVersion = "fauxPasVersion"
let reportModelVersionControlRevision = "versionControlRevision"
let reportModelTargetName = "targetName"
let reportModelProjectPath = "projectPath"
let reportModelTimeStamp = "timeStamp"
let reportModelProjectIconBase64PNG = "projectIconBase64PNG"
let reportModelVersionControlSystemName = "versionControlSystemName"
let reportModelProjectName = "projectName"
let reportModelTargetBundleVersion = "targetBundleVersion"
let reportModelDiagnostics = "diagnostics"

public class ReportModel: NSObject, NSCoding, NSCopying {
  var buildConfigurationName: String?
  var fauxPasVersion: String?
  var versionControlRevision: String?
  var targetName: String?
  var projectPath: String?
  var timeStamp: Double?
  var projectIconBase64PNG: String?
  var versionControlSystemName: String?
  var projectName: String?
  var targetBundleVersion: String?
  var diagnostics = [AnyObject]()
  
  override init() {
    super.init()
  }

  class func modelObject(withDictionary dict: [AnyHashable: Any]) -> ReportModel {
    return ReportModel.init(dictionary: dict)
  }

  init(dictionary dict: [AnyHashable: Any]) {
    super.init()
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
      self.buildConfigurationName = dict[reportModelBuildConfigurationName] as? String ?? ""
      self.fauxPasVersion = dict[reportModelFauxPasVersion] as? String ?? ""
      self.versionControlRevision = dict[reportModelVersionControlRevision] as? String ?? ""
      self.targetName = dict[reportModelTargetName] as? String ?? ""
      self.projectPath = dict[reportModelProjectPath] as? String ?? ""
      self.timeStamp = dict[reportModelTimeStamp] as? Double ?? 0
      self.projectIconBase64PNG = dict[reportModelProjectIconBase64PNG] as? String ?? ""
      self.versionControlSystemName = dict[reportModelVersionControlSystemName] as? String ?? ""
      self.projectName = dict[reportModelProjectName] as? String ?? ""
      self.targetBundleVersion = dict[reportModelTargetBundleVersion] as? String ?? ""
    var parsedDiagnostics = [AnyObject]()
    if let receivedDiagnostics = dict[reportModelDiagnostics] as?  [AnyObject] {
        for item in receivedDiagnostics {
          if let itemDic = item as? [AnyHashable: Any] {
            parsedDiagnostics.append(Diagnostics.modelObject(withDictionary: itemDic))
          }
        }
      } else if let receivedDiagnostics = dict[reportModelDiagnostics] as? [AnyHashable: Any] {
        parsedDiagnostics.append(Diagnostics.modelObject(withDictionary: receivedDiagnostics))
      }
      self.diagnostics = (arrayLiteral: parsedDiagnostics) as [AnyObject]
  }

  func dictionaryRepresentation() -> [AnyHashable: Any] {
    var mutableDict = [AnyHashable: Any]()
    mutableDict[reportModelBuildConfigurationName] = self.buildConfigurationName
    mutableDict[reportModelFauxPasVersion] = self.fauxPasVersion
    mutableDict[reportModelVersionControlRevision] = self.versionControlRevision
    mutableDict[reportModelTargetName] = self.targetName
    mutableDict[reportModelProjectPath] = self.projectPath
    mutableDict[reportModelTimeStamp] = self.timeStamp
    mutableDict[reportModelProjectIconBase64PNG] = self.projectIconBase64PNG
    mutableDict[reportModelVersionControlSystemName] = self.versionControlSystemName
    mutableDict[reportModelProjectName] = self.projectName
    mutableDict[reportModelTargetBundleVersion] = self.targetBundleVersion
    var tempArrayForDiagnostics = [Any]()
    for subArrayObject: AnyObject in self.diagnostics {
      if subArrayObject.responds(to: #selector(self.dictionaryRepresentation)) {
        // This class is a model object
        tempArrayForDiagnostics.append(subArrayObject.perform(#selector(self.dictionaryRepresentation)))
      } else {
        // Generic object
        tempArrayForDiagnostics.append(subArrayObject)
      }
    }
    mutableDict[reportModelDiagnostics] = [Any](arrayLiteral: tempArrayForDiagnostics)
    return mutableDict
  }

  // MARK: - NSCoding Methods
  required public init?(coder aDecoder: NSCoder) {
    super.init()
    self.buildConfigurationName = aDecoder.decodeObject(forKey: reportModelBuildConfigurationName) as? String
    self.fauxPasVersion = aDecoder.decodeObject(forKey: reportModelFauxPasVersion) as? String
    self.versionControlRevision = aDecoder.decodeObject(forKey: reportModelVersionControlRevision)as? String
    self.targetName = aDecoder.decodeObject(forKey: reportModelTargetName) as? String
    self.projectPath = aDecoder.decodeObject(forKey: reportModelProjectPath) as? String
    self.timeStamp = aDecoder.decodeDouble(forKey: reportModelTimeStamp)
    self.projectIconBase64PNG = aDecoder.decodeObject(forKey: reportModelProjectIconBase64PNG) as? String
    self.versionControlSystemName = aDecoder.decodeObject(forKey: reportModelVersionControlSystemName) as? String
    self.projectName = aDecoder.decodeObject(forKey: reportModelProjectName) as? String
    self.targetBundleVersion = aDecoder.decodeObject(forKey: reportModelTargetBundleVersion) as? String
    self.diagnostics = aDecoder.decodeObject(forKey: reportModelDiagnostics) as? [AnyObject] ?? [AnyObject]()
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(buildConfigurationName, forKey: reportModelBuildConfigurationName)
    aCoder.encode(fauxPasVersion, forKey: reportModelFauxPasVersion)
    aCoder.encode(versionControlRevision, forKey: reportModelVersionControlRevision)
    aCoder.encode(targetName, forKey: reportModelTargetName)
    aCoder.encode(projectPath, forKey: reportModelProjectPath)
    aCoder.encode(timeStamp, forKey: reportModelTimeStamp)
    aCoder.encode(projectIconBase64PNG, forKey: reportModelProjectIconBase64PNG)
    aCoder.encode(versionControlSystemName, forKey: reportModelVersionControlSystemName)
    aCoder.encode(projectName, forKey: reportModelProjectName)
    aCoder.encode(targetBundleVersion, forKey: reportModelTargetBundleVersion)
    aCoder.encode(diagnostics, forKey: reportModelDiagnostics)
  }

  public func copy(with zone: NSZone?) -> Any {
    let copy = ReportModel.init()
      copy.buildConfigurationName = self.buildConfigurationName
      copy.fauxPasVersion = self.fauxPasVersion
      copy.versionControlRevision = self.versionControlRevision
      copy.targetName = self.targetName
      copy.projectPath = self.projectPath
      copy.timeStamp = self.timeStamp
      copy.projectIconBase64PNG = self.projectIconBase64PNG
      copy.versionControlSystemName = self.versionControlSystemName
      copy.projectName = self.projectName
      copy.targetBundleVersion = self.targetBundleVersion
      copy.diagnostics = self.diagnostics
    return copy
  }

}
