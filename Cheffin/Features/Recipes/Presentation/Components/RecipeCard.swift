//
//  RecipeCard.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import SwiftUI
import SwiftUITooltip

struct RecipeCard: View {
    
    @State var recipe: Recipe
    
    var body: some View {
        VStack {
            // MARK: Recipe Image
            Image(recipe.image)
                .resizable()
                .frame(height: UIScreen.main.bounds.height * (1 / 4))
                .scaledToFill()
            
            VStack(alignment: .leading) {
                // MARK: Recipe Description
                Text(recipe.name)
                    .font(.system(.title, weight: .bold))
                HStack {
                    Image(systemName: "clock")
                    Text(recipe.duration)
                        .font(.footnote)
                }
                .font(.system(.headline, weight: .medium))
                Text(recipe.description)
                    .font(.subheadline)
                    .padding(.vertical, 4)
                    .lineLimit(4)
                    .truncationMode(.tail)
                Text("\(S.essentialUtensils):")
                    .font(.system(.subheadline, weight: .semibold))
                HStack {
                    ForEach(recipe.utensils.filter { utensil in
                        utensil.isEssential
                    }) { utensil in
                        Tooltip(utensil: utensil)
                    }
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .foregroundStyle(I.textPrimary.swiftUIColor)
        .background(I.primary.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = Recipe(
            id: UUID(),
            name: "Garlic-Butter Steak",
            description: """
        Garlic Steak Butter is a rich and flavorful \
        compound butter that combines the savory \
        essence of garlic with the richness of \
        butter to create a delectable \
        accompaniment for steaks. This buttery \
        concoction is made by blending minced \
        garlic into softened butter along with \
        various complementary herbs and spices.
        """,
            duration: "30 - 45 Minutes",
            image: "GarlicButterSteak",
            utensils: [
                Utensil(
                    id: UUID(),
                    name: "Knife",
                    image: "Knife",
                    isEssential: true),
                Utensil(
                    id: UUID(),
                    name: "Thermometer",
                    image: "Thermometer",
                    isEssential: true)
            ],
            ingredients: [],
            instructions: []
        )
        RecipeCard(
            recipe: recipe
        )
    }
}

struct Tooltip: View {
    
    @State var tooltipVisible = false
    @State var utensil: Utensil
    
    var body: some View {
        Image(utensil.image)
            .onTapGesture {
                tooltipVisible.toggle()
            }
            .tooltip(self.tooltipVisible, side: .top) {
                Text(utensil.name)
            }
    }
}
