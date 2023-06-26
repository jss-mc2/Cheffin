//
//  StepByStep.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 25/06/23.
//

import Foundation

struct StepByStep: Identifiable, Hashable {
    let id: UUID
    let title: String
    let media: String
    let mediaType: InstructionMediaType
    let order: Int
    let instruction: String
    let timer: TimeInterval?
}
