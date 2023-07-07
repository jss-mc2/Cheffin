//
//  DescriptionHighlight.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

struct StepByStepDescriptionView: View {
    let description: String
    
    init(_ description: String) {
        self.description = description
        
        print("\(type(of: self)) \(#function) \(description)")
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
        let strings = String.separateString(description, delimiters: delimiters)
        
        var result = Text("")
        
        for string in strings {
            if delimiters.contains(where: string.contains) {
                result = result + Text(String.removeDelimiters(string, delimiters: delimiters))
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
}
