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
    /// expected value: starting from 1
    let order: Int
    let instruction: String
    let timer: TimeInterval?
}

#if DEBUG
extension StepByStep {
    static let SAMPLEDATA = [
        StepByStep(
            id: UUID(),
            title: "title1",
            media: "https://www.w3schools.com/images/w3schools_green.jpg",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 1,
            instruction: "instruction1",
            timer: nil
        ),
        StepByStep(
            id: UUID(),
            title: "title2",
            media: "https://www.w3schools.com/images/w3schools_green.jpg",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 2,
            instruction: "instruction2",
            timer: 10
        ),
        StepByStep(
            id: UUID(),
            title: "title3",
            media: "https://www.w3schools.com/images/w3schools_green.jpg",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 3,
            instruction: "instruction3",
            timer: nil
        )
    ]
}
#endif
