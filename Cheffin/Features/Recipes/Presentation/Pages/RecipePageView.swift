//
//  RecipePageView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct RecipePageView: View {
    
	 var recipe: Recipe
	@State var isStepByStepModeOn = false
	@StateObject var viewModel: RecipeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
					AsyncImage(url: URL(string: recipe.image)) { image in
						image
							.resizable()
							.aspectRatio(contentMode: .fill)
					} placeholder: {
						ProgressView()
					}
                }
                HStack {
					Text(recipe.name)
                        .padding(.horizontal)
                        .font(Font.title.weight(.bold))
                }
                HStack {
                    Image("clock")
                        .padding(.leading)
					Text(recipe.duration)
                }
                .padding(.bottom)
                HStack {
					Text(recipe.description)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                }
                .padding(.bottom)
                HStack {
					Text(S.ingredients)
                        .font(Font.title2.weight(.bold))
                        .padding(.leading)
                }
				IngredientsGridView(ingredients: recipe.ingredients)
                    .padding(.bottom)
                
                HStack {
					Text(S.utensils)
                        .font(Font.title2.weight(.bold))
                        .padding(.leading)
                    Spacer()
                }
				UtensilsGridView(utensils: recipe.utensils)
                    .padding(.bottom)
                
                HStack {
					Text(S.stepByStep)
                        .font(Font.title2.weight(.bold))
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
				
				StepsView(instructions: recipe.instructions)
                    .padding(.bottom)
            }
            
            Button(action: {
				isStepByStepModeOn.toggle()
                        // Button action code
                    }) {
                        Text("Let's Cook!")
                            .font(.headline)
                            .frame(width: 358, height: 44)
                            .background(Color(red: 246 / 255, green: 200 / 255, blue: 79 / 255))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    }
            
		}
		.sheet(isPresented: $isStepByStepModeOn) {
			StepByStepPageView(viewModel.state.stepBySteps)
		}
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
        RecipePageView(recipe: recipe[0], viewModel: viewModel)
    }
}






//            Button("Let's Cook") {
//                print("Button pressed")
//            }
//            .padding(.horizontal)
//            .background(Color(red: 246/255, green: 200/255, blue: 79/255))
//            .foregroundStyle(.black)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
