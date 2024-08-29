//
//  Masked.swift
//  SmartTrials
//
//  Created by JimmyChao on 2024/8/13.
//

import Foundation



public extension String {

    func masked(firstDigits: Int, lastDigits: Int, with template: String = "*") -> String {
        let totalLength = count
        guard firstDigits + lastDigits < totalLength else {

            return ""
        }
        
        do {
            let regexPattern = "(?<=.{" + String(firstDigits) + "}).(?=.*.{" + String(lastDigits) + "}$)"
            let regex = try NSRegularExpression(pattern: regexPattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, totalLength)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: template)
        } catch {

            return ""
        }
    }
}
