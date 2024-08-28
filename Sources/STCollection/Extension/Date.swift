//
//  Date.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/2.
//

import Foundation
import SwiftUI
import os

public extension Date {
    
    func isInSameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .month)
    }
    
    func isInSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: date, toGranularity: .day)
    }
    
    func isAfter(_ date: Date) -> Bool {
        let startOfDay = Calendar.current.startOfDay(for: self)
        
        return date < startOfDay
    }
    
    func isBefore(_ date: Date) -> Bool {
        let startOfDay = Calendar.current.startOfDay(for: self)
        return date > startOfDay
    }
}
