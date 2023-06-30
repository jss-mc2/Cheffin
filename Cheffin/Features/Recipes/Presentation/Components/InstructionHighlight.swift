//
//  DescriptionHighlight.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

struct InstructionHighlight: View {
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
    
    var body: some View {
        HStack {
            handler(description)
        }
    }
    
    /**
     - Parameters:
     - description: something something something Add [steak] to {pan} for <5 minutes>
     - Returns:
     ```
     Text("something something something ").bold()
     + Text("Add ").bold()
     + Text("steak ").bold().foregroundColor(.blue)
     + Text("pan ").bold().foregroundColor(.blue)
     + Text("for ").bold()
     + Text("5 minutes ").bold().foregroundColor(.blue)
     ```
     */
    func handler(_ description: String) -> some View {
        let delimiters: [Character] = ["[", "]", "{", "}", "<", ">"]
        let strings = separateString(description, delimiters: delimiters)
        
        var result = Text("")
        
        for string in strings {
            if delimiters.contains(where: string.contains) {
                result = result + Text(removeDelimiters(string, delimiters: delimiters))
                    .foregroundColor(I.primary.swiftUIColor)
                    .font(.system(.largeTitle, weight: .bold))
            } else {
                result = result + Text(string)
                    .foregroundColor(I.textPrimary.swiftUIColor)
                    .font(.system(.largeTitle, weight: .bold))
            }
        }
        
        return result
    }
    
    private func removeDelimiters(_ string: String, delimiters: [Character]) -> String {
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
    private func separateString(_ string: String, delimiters: [Character]) -> [String] {
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
