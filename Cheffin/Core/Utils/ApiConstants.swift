//
//  ApiConstants.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 26/06/23.
//

import Foundation

enum ApiConstants {
    static let baseUrl: String = "https://raw.githubusercontent.com/jss-mc2/japchae-api/main/api/"
}

extension ApiConstants {
    static func createRequest(path: String) throws -> URLRequest {
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            throw Failure.recipeFailure
        }
        return URLRequest(url: url)
    }

}
