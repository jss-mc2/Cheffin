//
//  IngredientsUtensilsGridView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct IngredientsGridView: View {
    
	let ingredients: [Ingredient]
    
    let layout = [
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center),
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center),
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center),
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center)
    ]
    
    
    var body: some View {
        LazyVGrid(columns: layout, alignment: .center, spacing: 10) {
            ForEach(ingredients) { ingredient in
                VStack {
					AsyncImage(url: URL(string: ingredient.image)) { image in
						image.resizable()
							.frame(width: UIScreen.main.bounds.width * (1 / 10),
								   height: UIScreen.main.bounds.width * (1 / 10)
							)
					} placeholder: {
						ProgressView()
					}

                    Text("\(ingredient.amount) \(ingredient.unit) \(ingredient.name)")
						.font(.caption)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

struct IngredientsUtensilsGridView_Previews: PreviewProvider {
    static var previews: some View {
		let ingredients = [
			Ingredient(id: UUID(), name: "Shallot", image: "shallot", amount: "8", unit: "cloves"),
			Ingredient(id: UUID(), name: "Garlic", image: "garlic", amount: "4", unit: "cloves"),
			Ingredient(id: UUID(), name: "Carrot", image: "carrot", amount: "", unit: ""),
			Ingredient(id: UUID(), name: "Potato", image: "potato", amount: "", unit: ""),
			Ingredient(id: UUID(), name: "Shallot", image: "shallot", amount: "8", unit: "cloves"),
			Ingredient(id: UUID(), name: "Garlic", image: "garlic", amount: "4", unit: "cloves"),
			Ingredient(id: UUID(), name: "Carrot", image: "carrot", amount: "", unit: ""),
			Ingredient(id: UUID(), name: "Potato", image: "potato", amount: "", unit: ""),
			Ingredient(id: UUID(), name: "Shallot", image: "shallot", amount: "8", unit: "cloves"),
			Ingredient(id: UUID(), name: "Garlic", image: "garlic", amount: "4", unit: "cloves"),
			Ingredient(id: UUID(), name: "Carrot", image: "carrot", amount: "", unit: ""),
			Ingredient(id: UUID(), name: "Potato", image: "potato", amount: "", unit: ""),
			Ingredient(id: UUID(), name: "Shallot", image: "shallot", amount: "8", unit: "cloves"),
			Ingredient(id: UUID(), name: "Garlic", image: "garlic", amount: "4", unit: "cloves"),
			Ingredient(id: UUID(), name: "Carrot", image: "carrot", amount: "", unit: "")
			
		]
		IngredientsGridView(ingredients: ingredients)
    }
}
