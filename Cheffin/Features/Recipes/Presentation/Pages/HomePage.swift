//
//  HomePage.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import SwiftUI

struct HomePage: View {
	
	let controller: HomeViewController
	@ObservedObject var viewModel: RecipeViewModel
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				Text(S.welcomeToCheffin)
					.font(.system(size: 28, weight: .bold))
				
				Text(S.whatDoYouWantToCookToday)
					.font(.footnote)
					.padding(.bottom, 16)
				
				ForEach(viewModel.state.recipes) { recipe in
					RecipeCard(recipe: recipe) {
						controller.navigateToRecipePage(recipe: recipe)
					}
				}
				
				.listRowSeparator(.hidden)
				.listStyle(.plain)
				
				
				.scrollContentBackground(.hidden)
			}
			
		}
		.padding(.all, 16)

		
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
		let controller = HomeViewController(viewModel: InjectionContainer.shared.container.resolve(RecipeViewModel.self)!)
		HomePage(controller: controller, viewModel: controller.viewModel)
    }
}
