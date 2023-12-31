//
//  RecipePageView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct RecipePageView: View {
    
    let controller: RecipeViewController
    
    var recipe: Recipe
	@State var isStepByStepModeOn = false
	@StateObject var viewModel: RecipeDetailViewModel
	@Environment(\.dismiss)
	private var dismiss
    
    var body: some View {
		ScrollView {
			ZStack {
				VStack(alignment: .leading) {
					Group {
						VStack {
							AsyncImage(url: URL(string: recipe.image)) { image in
								image
									.resizable()
									.scaledToFill()
									.frame(
										width: UIScreen.main.bounds.width,
										height: UIScreen.main.bounds.height * (1 / 3))
									.clipped()
							} placeholder: {
								ProgressView()
									.padding(.top, 48)
							}
							.contentShape(Rectangle())
						}
					}
					Group {
						HStack {
							Text(recipe.name)
								.padding(.horizontal)
								.font(Font.title.weight(.bold))
						}
                        .padding(.bottom, -1)
						HStack {
							Image("clock")
								.padding(.leading)
							Text(recipe.duration)
						}
						.padding(.bottom, 10)
					}
				
					Group {
						HStack {
							Text(recipe.description)
								.padding(.horizontal)
								.multilineTextAlignment(.leading)
								.font(.body)
						}
						.padding(.bottom, 35)
					}
					
					Group {
						HStack {
							Text(S.ingredients)
								.font(Font.title2.weight(.bold))
								.padding(.leading)
						}
						IngredientsGridView(ingredients: recipe.ingredients)
							.padding(.bottom, 35)
						
						HStack {
							Text(S.utensils)
								.font(Font.title2.weight(.bold))
								.padding(.leading)
							Spacer()
						}
						UtensilsGridView(utensils: recipe.utensils)
							.padding(.bottom, 35)
					}
					
					Group {
						HStack {
							Text(S.stepByStep)
								.font(Font.title2.weight(.bold))
								.padding(.leading)
							Spacer()
						}
						.padding(.bottom)
						
						StepsView(instructions: recipe.instructions)
						
					}
					Button {
						isStepByStepModeOn.toggle()
					} label: {
						Text("Let's Cook!")
							.font(.headline)
							.frame(maxWidth: .infinity)
							.cornerRadius(10)
							.foregroundColor(.black)
                            .padding()
					}
					.buttonStyle(.borderedProminent)
					.tint(I.primary.swiftUIColor)
					.padding()

				}
				
				VStack {
					HStack {
						Image(systemName: "chevron.backward")
							.resizable()
							.foregroundColor(.white)
							.frame(width: 16, height: 24)
							.clipped()
							.onTapGesture {
								dismiss()
							}
						Spacer()
					}
					Spacer()
				}
				.padding(EdgeInsets(top: 48, leading: 24, bottom: 48, trailing: 24))
			}
			.fullScreenCover(isPresented: $isStepByStepModeOn) {
                StepByStepPageView(controller: controller, steps: viewModel.state.stepBySteps)
				
			}
		}
		.ignoresSafeArea(edges: .top)
    }
}

struct RecipePageView_Previews: PreviewProvider {
    static var previews: some View {
		let fakeData = RecipeFakeDataSource()
		let response: [RecipeResponse] = fakeData.getRecipes()
		let recipe = response.map {
			$0.toDomain()
		}
		let viewModel = InjectionContainer.shared.container.resolve(RecipeDetailViewModel.self)!
        let controller = RecipeViewController(recipe: recipe[0], viewModel: viewModel)
        RecipePageView(controller: controller, recipe: recipe[0], viewModel: viewModel)
    }
}
