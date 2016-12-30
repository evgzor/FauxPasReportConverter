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
            
            return (self as NSString).deletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).deletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(_ path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(_ ext: String) -> String? {
        
        let nsSt = self as NSString  
        
        return nsSt.appendingPathExtension(ext)  
    }
    
    func runCommand (_ commandToRun : String) -> String
    {
        let task = Process.init()
        task.launchPath = "/bin/sh"
    
        let arguments : Array = ["-c" ,String(format :"%@", commandToRun)]
        task.arguments = arguments
        let pipe = Pipe()
        task.standardOutput = pipe
        
        let file = pipe.fileHandleForReading
    
        task.launch()
    
        let data = file.readDataToEndOfFile
    
        let output = String.init(data: data(), encoding: String.Encoding.utf8)
        
    return output!
    }
}
