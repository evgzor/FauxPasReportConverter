//
//  StringToPath.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 06/07/16.
//  Copyright © 2016 Eugene Zorin. All rights reserved.
//

import Foundation

extension String {
    
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString  
        
        return nsSt.stringByAppendingPathExtension(ext)  
    }
    
    func runCommand (commandToRun : String) -> String
    {
        let task = NSTask.init()
        task.launchPath = "/bin/sh"
    
        let arguments : Array = ["-c" ,String(format :"%@", commandToRun)]
        task.arguments = arguments
        let pipe = NSPipe()
        task.standardOutput = pipe
        
        let file = pipe.fileHandleForReading
    
        task.launch()
    
        let data = file.readDataToEndOfFile
    
        let output = String.init(data: data(), encoding: NSUTF8StringEncoding)
        
    return output!
    }
}