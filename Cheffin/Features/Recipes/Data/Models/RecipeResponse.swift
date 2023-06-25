//
//  RecipeResponse.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 26/06/23.
//

import Foundation

struct RecipeResponse: Codable {
    let id, name, description, duration: String?
    let image: String?
    let utensils: [UtensilResponse]?
    let ingredients: [IngredientResponse]?
    let instructions: [InstructionResponse]?
}
