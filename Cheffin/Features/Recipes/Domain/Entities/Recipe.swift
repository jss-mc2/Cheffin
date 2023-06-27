//
//  Recipe.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import Foundation

struct Recipe: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let duration: String
    let image: String
    let utensils: [Utensil]
    let ingredients: [Ingredient]
    let instructions: [Instruction]

}
