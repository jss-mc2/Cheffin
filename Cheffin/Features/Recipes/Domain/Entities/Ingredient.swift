//
//  Ingredient.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 25/06/23.
//

import Foundation

struct Ingredient: Identifiable, Hashable {
    let id: UUID
    let name: String
    let image: String
    let amount: String
    let unit: String
}
