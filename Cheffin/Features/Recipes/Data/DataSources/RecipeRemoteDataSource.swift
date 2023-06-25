//
//  RecipeRemoteDataSource.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import Foundation
import Combine

protocol RecipeRemoteDataSource {
    func getRecipes() -> AnyPublisher<[RecipeResponse], Failure>
}

class RecipeRemoteDataSourceGithubImpl: RecipeRemoteDataSource {

    let apiClient: URLSession

    init(apiClient: URLSession) {
        self.apiClient = apiClient
    }
    func getRecipes() -> AnyPublisher<[RecipeResponse], Failure> {
        guard let request = try? ApiConstants.createRequest(path: "recipes.json") else {
			debugPrint("cannot create request")
            return Fail(error: Failure.recipeFailure).eraseToAnyPublisher()
        }

		return apiClient.dataTaskPublisher(for: request)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: RecipeApiResponse.self, decoder: JSONDecoder())
            .map { $0.data ?? [] }
            .mapError { error in
				debugPrint(error)
                return Failure.recipeFailure
            }
            .eraseToAnyPublisher()
    }


}
