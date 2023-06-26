//
//  ViewStepByStepMode.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/06/23.
//

import Foundation
import Combine

protocol ViewStepByStepMode: UseCaseProtocol {
    associatedtype ReturnType = [StepByStep]
    associatedtype Params = ViewStepByStepModeParams
}

class ViewStepByStepModeImpl: ViewStepByStepMode {
    let parser: InstructionParser
    
    init(parser: InstructionParser) {
        self.parser = parser
    }
    
    func execute(params: ViewStepByStepModeParams, completion: @escaping (AnyPublisher<[StepByStep], Failure>) -> Void) {
        completion(parser.parse(recipe: params.recipe))
    }
}

struct ViewStepByStepModeParams: Equatable {
    let recipe: Recipe
}
