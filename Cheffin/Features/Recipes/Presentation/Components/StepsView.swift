//
//  StepsView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct StepsView: View {
    
    let instructions: [Instruction]
    
    
    var body: some View {
        ForEach(instructions) { item in
            HStack {
				Text(String(item.order))
                    .padding(.horizontal)
                    .font(Font.headline)
                Text(item.description)
                Spacer()
            }
        }
    }
}


struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
		let fakeData = RecipeFakeDataSource()
		let response: [RecipeResponse] = fakeData.getRecipes()
		let recipe = response.map {
			$0.toDomain()
		}
		StepsView(instructions: recipe[0].instructions)
    }
}
