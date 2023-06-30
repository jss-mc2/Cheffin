//
//  IngredientsUtensilsGridView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct IngredientsGridView: View {
    
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
    
    let layout = [
        GridItem(.fixed(62), spacing: 25, alignment: nil),
        GridItem(.fixed(62), spacing: 25, alignment: nil),
        GridItem(.fixed(62), spacing: 25, alignment: nil),
        GridItem(.fixed(62), spacing: 25, alignment: nil)
    ]
    
    
    var body: some View {
        LazyVGrid(columns: layout, alignment: .center, spacing: 25) {
            ForEach(ingredients) { ingredient in
                VStack {
                    Image(ingredient.image)
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
        IngredientsGridView()
    }
}
