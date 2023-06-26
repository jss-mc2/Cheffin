//
//  InstructionResponse.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 26/06/23.
//

import Foundation

struct InstructionResponse: Codable {
    let id: String?
    let order: Int?
    let title, description, media, mediaType: String?
    let usedUtensils: [UtensilResponse]?
    let usedIngredients: [IngredientResponse]?

    enum CodingKeys: String, CodingKey {
        case id, order, title, description, media
        case mediaType = "media_type"
        case usedUtensils = "used_utensils"
        case usedIngredients = "used_ingredients"
    }
}

extension InstructionResponse {
    func toDomain() -> Instruction {
        Instruction(
            id: .init(uuidString: id ?? UUID().uuidString) ?? UUID(),
            order: order ?? 1,
            description: description ?? "",
            media: media ?? "",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: mediaType ?? ""),
            usedUtensils: usedUtensils?.map { $0.toDomain() } ?? [],
            usedIngredients: usedIngredients?.map { $0.toDomain() } ?? []
        )
    }
}
