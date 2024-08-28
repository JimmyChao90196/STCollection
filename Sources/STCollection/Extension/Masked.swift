//
//  Masked.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/13.
//

import Foundation
import os

fileprivate let logger = Logger(subsystem: "SmartTools", category: "StringExtension")

public extension String {

    func masked(firstDigits: Int, lastDigits: Int, with template: String = "*") -> String {
        let totalLength = count
        guard firstDigits + lastDigits < totalLength else {
            logger.log("Error: The sum of firstDigits and lastDigits must be less than the length of the string.")
            return ""
        }
        
        do {
            let regexPattern = "(?<=.{" + String(firstDigits) + "}).(?=.*.{" + String(lastDigits) + "}$)"
            let regex = try NSRegularExpression(pattern: regexPattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, totalLength)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: template)
        } catch {
            logger.log("Error creating regex: \(error.localizedDescription)")
            return ""
        }
    }
}
