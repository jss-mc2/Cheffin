//
//  Instruction.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 25/06/23.
//

import Foundation

struct Instruction: Identifiable, Hashable {
    let id: UUID
    let order: Int
    let description: String
    let media: String
	let mediaType: InstructionMediaType
	let usedUtensils: [Utensil]
	let usedIngredients: [Ingredient]
}

enum InstructionMediaType {
    case gif, photo, video
}

extension InstructionMediaType {
	func toStringType() -> String {
		switch self {
		case .gif: return "gif"
		case .photo: return "photo"
		case .video: return "video"
		}
	}
	static func fromStringType(stringMediaType: String) throws -> InstructionMediaType {
		switch stringMediaType {
		case "gif": return .gif
		case "photo": return .photo
		case "video": return .video
		default: throw Failure.recipeFailure
		}
	}
}
