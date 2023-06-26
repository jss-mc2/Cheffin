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

extension IngredientResponse {

    func toDomain() -> Ingredient {
        Ingredient(
            id: (.init(uuidString: id ?? UUID().uuidString)) ?? UUID(),
            name: name ?? "",
            image: image ?? "",
            amount: amount ?? "",
            unit: unit ?? ""
        )
    }
}
