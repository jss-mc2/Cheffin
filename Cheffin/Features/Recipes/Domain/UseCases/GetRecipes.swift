//
//  GetRecipes.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import Foundation
import Combine

protocol GetRecipes: UseCaseProtocol {
    associatedtype ReturnType = [Recipe]
    associatedtype Params = NoParams
}

class GetRecipeImpl: GetRecipes {

    let repository: RecipeRepository

    init(repository: RecipeRepository) {
        self.repository = repository
    }

    func execute(params: NoParams, completion: @escaping (AnyPublisher<[Recipe], Failure>) -> Void) {
        completion(repository.getRecipes())
    }

}
