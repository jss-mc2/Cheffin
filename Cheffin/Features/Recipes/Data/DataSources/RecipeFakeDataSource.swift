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
		recipes.append(buildRecipeResponse())

        
        return Just(recipes)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    private func buildUtensilResponse() -> [UtensilResponse] {
		return [
			UtensilResponse(
			id: UUID().uuidString,
			name: "Knife",
			image: "https://pngimg.com/d/knife_PNG106098.png",
			isEssential: true
			),
			UtensilResponse(
				id: UUID().uuidString,
				name: "Thermometer",
				image: "https://pngimg.com/d/thermometer_PNG63.png",
				isEssential: true
			)
		]
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
            usedUtensils: buildUtensilResponse(),
            usedIngredients: [buildIngredientResponse()]
        )
    }
    
    private func buildRecipeResponse() -> RecipeResponse {
        return RecipeResponse(
			id: UUID().uuidString,
			name: "Garlic-Butter Steak",
			description: """
		Garlic Steak Butter is a rich and flavorful \
		compound butter that combines the savory \
		essence of garlic with the richness of \
		butter to create a delectable \
		accompaniment for steaks. This buttery \
		concoction is made by blending minced \
		garlic into softened butter along with \
		various complementary herbs and spices.
		""",
			duration: "30 - 45 Minutes",
			image: "https://images.unsplash.com/photo-1600891964092-4316c288032e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
            utensils: buildUtensilResponse(),
            ingredients: [buildIngredientResponse()],
            instructions: [buildInstructionResponse()]
        )
    }
    
}
