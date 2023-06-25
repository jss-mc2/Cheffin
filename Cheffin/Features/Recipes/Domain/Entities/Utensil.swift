//
//  Utensil.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 25/06/23.
//

import Foundation

struct Utensil: Identifiable, Hashable {
    let id: UUID
    let name: String
    let image: String
    let isEssential: Bool
}
