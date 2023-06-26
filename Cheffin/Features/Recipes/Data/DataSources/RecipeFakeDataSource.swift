//
//  FakeDataFactory.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/06/23.
//

import Foundation
import Combine

class RecipeFakeDataSource: RecipeRemoteDataSource {
    func getRecipes() -> AnyPublisher<[RecipeResponse], Failure> {
        var recipes: [RecipeResponse] = []
        
        recipes.append(buildRecipeResponse())
        
        return Just(recipes)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    private func buildUtensilResponse() -> UtensilResponse {
        return UtensilResponse(
            id: UUID().uuidString,
            name: "Pan",
            image: "https://www.w3schools.com/images/w3schools_green.jpg",
            isEssential: true
        )
    }
    
    private func buildIngredientResponse() -> IngredientResponse {
        return IngredientResponse(
            id: UUID().uuidString,
            name: "Egg",
            image: "https://www.w3schools.com/images/w3schools_green.jpg",
            amount: "1",
            unit: "pc"
        )
    }
    
    private func buildInstructionResponse() -> InstructionResponse {
        return InstructionResponse(
            id: UUID().uuidString,
            order: 1,
            title: "Break the egg",
            description: "Break the egg brother",
            media: "https://www.w3schools.com/images/w3schools_green.jpg",
            mediaType: "photo",
            usedUtensils: [buildUtensilResponse()],
            usedIngredients: [buildIngredientResponse()]
        )
    }
    
    private func buildRecipeResponse() -> RecipeResponse {
        return RecipeResponse(
            id: UUID().uuidString,
            name: "Scrambled Egg",
            description: "Scrambled Egg is good",
            duration: "5 minutes",
            image: "https://www.w3schools.com/images/w3schools_green.jpg",
            utensils: [buildUtensilResponse()],
            ingredients: [buildIngredientResponse()],
            instructions: [buildInstructionResponse()]
        )
    }
    
}
