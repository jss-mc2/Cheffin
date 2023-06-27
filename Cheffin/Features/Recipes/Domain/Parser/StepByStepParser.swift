//
//  RecipeParser.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/06/23.
//

import Foundation
import Combine

protocol StepByStepParser {
    func parse(recipe: Recipe) -> AnyPublisher<[StepByStep], Failure>
}

class StepByStepParserImpl: StepByStepParser {
    func parse(recipe: Recipe) -> AnyPublisher<[StepByStep], Failure> {
        
        let steps = recipe.instructions.map { instruction in
            let parsedIngredient = parseIngredients(
                description: instruction.description, usedIngredients: instruction.usedIngredients.map { $0.name })
            let parsedUtensils = parseUtensils(
                description: parsedIngredient, usedUtensils: instruction.usedUtensils.map { $0.name })
            let parsedTimer = parseTimer(description: parsedUtensils)
            
            return StepByStep(
                id: instruction.id,
                title: instruction.title,
                media: instruction.media,
                mediaType: instruction.mediaType,
                order: instruction.order,
                instruction: parsedTimer,
                timer: convertTimer(description: instruction.description)
            )
        }
        
        return Just(steps)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    
    // expected description: "Add steak to pan rest for 1 hour and 5 minutes"
    // expected output: "Add [steak] to pan rest for 1 hour and 5 minutes"
    internal func parseIngredients(description: String, usedIngredients: [String]) -> String {
        var parsedDescription = description
        for ingredient in usedIngredients {
            parsedDescription = parsedDescription.replacingOccurrences(
                of: "\\b(?i)\(ingredient)\\b", with: "[\(ingredient)]", options: .regularExpression)
        }
        return parsedDescription
    }
    
    // expected description: "Add [steak] to pan rest for 1 hour and 5 minutes"
    // expected output: "Add [steak] to {pan} rest for 1 hour and 5 minutes"
    internal func parseUtensils(description: String, usedUtensils: [String]) -> String {
        var parsedDescription = description
        for utensil in usedUtensils {
            parsedDescription = parsedDescription.replacingOccurrences(
                of: "\\b(?i)\(utensil)\\b", with: "{\(utensil)}", options: .regularExpression)
        }
        return parsedDescription
    }
    
    // expected description: "Add [steak] to {pan} rest for 1 hour and 5 minutes"
    // expected output: "Add [steak] to {pan} rest for <1 hour> and <5 minutes>"
    internal func parseTimer(description: String) -> String {
        var parsedDescription = description
        
        parsedDescription = parsedDescription.replacingOccurrences(
            of: "\\b(\\d+) ((?i)minute[s]?|(?i)second[s]?|(?i)hour[s]?)?\\b",
            with: "<$1 $2>",
            options: .regularExpression
        )
        
        return parsedDescription
    }
    
    // expected description: "Add steak to pan rest for 1 hour and 5 minutes"
    // expected output: 3900
    internal func convertTimer(description: String) -> TimeInterval? {
        let words = description.components(separatedBy: " ")
        
        var timeInterval: TimeInterval = 0
        
        for i in 0..<words.count - 1 {
            let value = words[i]
            let unit = words[i + 1]
            
            if let intValue = Double(value) {
                switch unit {
                case "minute", "minutes":
                    timeInterval += intValue * 60
                case "second", "seconds":
                    timeInterval += intValue
                case "hour", "hours":
                    timeInterval += intValue * 3600
                default:
                    break
                }
            }
        }
        
        return timeInterval != 0 ? timeInterval : nil
    }
}
