//
//  RecipeRepository.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import Foundation
import Combine

protocol RecipeRepository {
    func getRecipes() -> AnyPublisher<[Recipe], Failure>
}
