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
            title: "Trim the fat of the meat",
            media: "https://images.unsplash.com/photo-1546964124-0cce460f38ef?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 1,
            instruction: "Trim the fat of the meat",
            timer: nil
        ),
        StepByStep(
            id: UUID(),
            title: "Heat the pan",
            media: "https://www.figma.com/file/IPf3dtEit6aa30UlRWhH6q/Mini-Challenge-2---iOS?type=design&node-id=2674-12930&mode=dev",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 2,
            instruction: "Heat the pan",
            timer: 10
        ),
        StepByStep(
            id: UUID(),
            title: "Pat meat dry",
            media: "https://www.figma.com/file/IPf3dtEit6aa30UlRWhH6q/Mini-Challenge-2---iOS?type=design&node-id=2674-13052&mode=dev",
            mediaType: InstructionMediaType.fromStringType(stringMediaType: "photo"),
            order: 3,
            instruction: "Pat meat dry",
            timer: nil
        )
    ]
}
#endif
