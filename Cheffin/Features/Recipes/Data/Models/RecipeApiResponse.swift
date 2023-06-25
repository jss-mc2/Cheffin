//
//  RecipeApiResponse.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import Foundation

struct RecipeApiResponse: Codable {
	let data: [RecipeResponse]?
	let meta: MetaResponse?
}

struct MetaResponse: Codable {
	let currentPage, from, lastPage: Int?
	let path: String?
	let perPage, to, total: Int?
	
	enum CodingKeys: String, CodingKey {
		case currentPage = "current_page"
		case from
		case lastPage = "last_page"
		case path
		case perPage = "per_page"
		case to, total
	}
}
