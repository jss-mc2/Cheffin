//
//  UtensilsGridView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct UtensilsGridView: View {
	
	let utensils: [Utensil]
    
    let layout = [
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center),
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center),
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center),
		GridItem(.flexible(minimum: UIScreen.main.bounds.width * (1 / 8)), spacing: 10, alignment: .center)
    ]
    
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 10) {
            ForEach(utensils) { utensil in
                VStack {
					AsyncImage(url: URL(string: utensil.image), content: { image in
						image.resizable()
							.frame(width: UIScreen.main.bounds.width * (1 / 10),
								   height: UIScreen.main.bounds.width * (1 / 10)
							)
					}, placeholder: {
						ProgressView()
					})
                    Text("\(utensil.name)")
						.font(.caption)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

struct UtensilsGridView_Previews: PreviewProvider {
    static var previews: some View {
		let utensils = [
			Utensil(id: UUID(), name: "Laddle", image: "laddle", isEssential: true),
			Utensil(id: UUID(), name: "Knife", image: "knife", isEssential: true),
			Utensil(id: UUID(), name: "Choping Board", image: "chopping_board", isEssential: true),
			Utensil(id: UUID(), name: "Soup Pot", image: "soup_pot", isEssential: true)
			
		]
        UtensilsGridView(utensils: utensils)
    }
}
