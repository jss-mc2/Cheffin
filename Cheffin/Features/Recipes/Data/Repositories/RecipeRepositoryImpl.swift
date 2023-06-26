//
//  RecipeRepositoryImpl.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import Foundation
import Combine

class RecipeRepositoryImpl: RecipeRepository {

    let remoteDataSource: RecipeRemoteDataSource

    init(remoteDataSource: RecipeRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getRecipes() -> AnyPublisher<[Recipe], Failure> {
        return remoteDataSource.getRecipes()
            .map { $0.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }


}
