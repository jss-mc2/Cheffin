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
