//
//  IngredientResponse.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 26/06/23.
//

import Foundation

struct IngredientResponse: Codable {
    let id, name, image, amount: String?
    let unit: String?
}
