//
//  UtensilResponse.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 26/06/23.
//

import Foundation

struct UtensilResponse: Codable {
    let id, name, image: String?
    let isEssential: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case isEssential = "is_essential"
    }
}

extension UtensilResponse {
    func toDomain() -> Utensil {
        Utensil(
            id: .init(uuidString: id ?? UUID().uuidString) ?? UUID(),
            name: name ?? "",
            image: image ?? "",
            isEssential: isEssential ?? false
        )
    }
}
