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

extension StepByStep {
    static let SAMPLEDATA = [
        StepByStep(
            id: UUID(),
            title: "Trim the fat of the meat",
            media: "https://github.com/jss-mc2/japchae-api/raw/main/media/recipes/sirloin_steak/1.mp4",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "video"),
            order: 1,
            instruction: "Trim the fat of the [meat]",
            timer: nil
        ),
        StepByStep(
            id: UUID(),
            title: "Heat the pan",
            media: "https://github.com/jss-mc2/japchae-api/blob/main/media/utensils/pan.png?raw=true",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 2,
            instruction: "Heat the {pan}",
            timer: 10
        ),
        StepByStep(
            id: UUID(),
            title: "Pat meat dry",
            media: "https://github.com/jss-mc2/japchae-api/blob/main/media/ingredients/chicken.png?raw=true",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 3,
            instruction: "Pat [meat] dry",
            timer: nil
        )
    ]
}
