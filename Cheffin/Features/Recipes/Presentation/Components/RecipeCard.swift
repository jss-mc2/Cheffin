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
	let onTap: () -> Void
    
    var body: some View {
		ViewThatFits {
			VStack {
				// MARK: Recipe Image
				AsyncImage(url: URL(string: recipe.image)) { image in
					image
						.resizable()
                        .aspectRatio(2, contentMode: .fit)
						.clipped()
				} placeholder: {
					ProgressView()
				}
				.contentShape(Rectangle())

				VStack(alignment: .leading) {
					// MARK: Recipe Description
					Text(recipe.name)
						.font(.system(size: 22, weight: .bold))
						.foregroundColor(I.blackText.swiftUIColor)
					HStack {
						Image(systemName: "clock")
						Text(recipe.duration)
							.font(.footnote)
					}
					.font(.system(.headline, weight: .medium))
					.foregroundColor(I.blackText.swiftUIColor)
					Text(recipe.description)
						.font(.subheadline)
						.padding(.vertical, 4)
						.lineLimit(4)
						.truncationMode(.tail)
						.foregroundColor(I.blackText.swiftUIColor)
					
					Text("\(S.essentialUtensils):")
						.font(.system(.subheadline, weight: .semibold))
						.foregroundColor(I.blackText.swiftUIColor)
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
			.onTapGesture {
				onTap()
			}
		.cornerRadius(10)
		}
		
		
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
            image: "https://images.unsplash.com/photo-1600891964092-4316c288032e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
            utensils: [
                Utensil(
                    id: UUID(),
                    name: "Knife",
                    image: "https://pngimg.com/d/knife_PNG106098.png",
                    isEssential: true
                ),
                Utensil(
                    id: UUID(),
                    name: "Thermometer",
                    image: "https://pngimg.com/d/thermometer_PNG63.png",
                    isEssential: true
                )
            ],
            ingredients: [],
            instructions: []
        )
        RecipeCard(recipe: recipe) {}
    }
}

struct Tooltip: View {
    
    @State private var tooltipVisible = false
    
    let utensil: Utensil
    var tooltipConfig = DefaultTooltipConfig()
    
    init(utensil: Utensil) {
        self.tooltipConfig.enableAnimation = true
        self.tooltipConfig.animationOffset = 10
        self.tooltipConfig.animationTime = 1
        self.tooltipConfig.borderColor = .white
        self.tooltipConfig.backgroundColor = I.background.swiftUIColor
        self.utensil = utensil
    }
    
    var body: some View {
        AsyncImage(url: URL(string: utensil.image)) { image in
            image
                .resizable()
                .frame(
                    maxWidth: UIScreen.main.bounds.width * (1 / 10),
                    maxHeight: UIScreen.main.bounds.height * (1 / 10)
                )
                .clipped()
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(I.primary.swiftUIColor)
                    .frame(height: UIScreen.main.bounds.height * (1 / 4))
                ProgressView()
                    .background(I.primary.swiftUIColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                tooltipVisible.toggle()
            }
        }
        .tooltip(self.tooltipVisible, side: .top, config: tooltipConfig) {
            Text(utensil.name)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.tooltipVisible.toggle()
                    }
                }
        }
    }
}
