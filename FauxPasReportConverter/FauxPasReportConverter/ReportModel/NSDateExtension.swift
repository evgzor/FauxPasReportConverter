//
//  NSDateExtension.swift
//  FauxPasReportConverter
//
//  Created by Eugene Zorin on 06/01/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

import Foundation
extension Date {
  
  public func numberOfDaysUntilDateTime(toDateTime: Date, calendar: Calendar) -> Int? {
  let fromDate = calendar.startOfDay(for: self)
  let toDate = calendar.startOfDay(for: toDateTime)
  let difference = calendar.dateComponents([.day], from: fromDate, to: toDate)
  return difference.day
  }
  
  
public func hoursBetweenForDate(date: Date) -> Double? {
    let secondsBetween = abs(self.timeIntervalSince(date))
    let secondsInHour = 3600.0
    
    return secondsBetween / secondsInHour
  }
  
}
