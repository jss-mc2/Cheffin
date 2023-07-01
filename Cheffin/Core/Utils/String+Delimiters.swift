//
//  String+RemoveDelimiters.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/07/23.
//

import Foundation

extension String {
    static func removeDelimiters(_ string: String, delimiters: [Character]) -> String {
        var cleanedString = string
        
        for delimiter in delimiters {
            cleanedString = cleanedString.replacingOccurrences(of: String(delimiter), with: "")
        }
        
        return cleanedString
    }
    
    /**
     - Parameters:
        - string: "something something Add [steak] to {pan} for <5 minutes>"
     */
    static func separateString(_ string: String, delimiters: [Character]) -> [String] {
        var result: [String] = []
        var currentString = ""
        var insideDelimiter = false
        
        for char in string {
            // result == ["something something soemthing Add "]
            if delimiters.contains(char) {
                // currentString == "[steak"
                // char == "]"
                if insideDelimiter {
                    currentString.append(char)
                }
                
                result.append(currentString)
                currentString = ""
                
                // currentString == ""
                // char == "["
                if !insideDelimiter {
                    currentString.append(char)
                }
                
                insideDelimiter.toggle()
            } else {
                currentString.append(char)
            }
        }
        
        return result
    }
}
