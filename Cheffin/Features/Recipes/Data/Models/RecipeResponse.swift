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

extension RecipeResponse {
    func toDomain() -> Recipe {
        Recipe(
            id: .init(uuidString: id ?? UUID().uuidString) ?? UUID(),
            name: name ?? "",
            description: description ?? "",
            duration: duration ?? "",
            image: image ?? "",
            utensils: utensils?.map { $0.toDomain() } ?? [],
            ingredients: ingredients?.map { $0.toDomain() } ?? [],
            instructions: instructions?.map { $0.toDomain() } ?? []
        )
    }
}
