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
        VStack(alignment: .leading) {
            ForEach(instructions) { item in
                HStack(alignment: .top) {
                    Text(String(item.order))
                        .frame(maxWidth: 22, alignment: .leading)
                        .padding(.leading)
                        .font(Font.headline)
                    Text(item.description)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.bottom, 5)
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
