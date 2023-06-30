//
//  RecipePageView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct RecipePageView: View {
    
    let steps: [StepByStep]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    Image("recipe_image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                HStack {
                    Text("Garlic-Butter Steak")
                        .padding(.horizontal)
                        .font(Font.title.weight(.bold))
                    Spacer()
                }
                HStack {
                    Image("clock")
                        .padding(.leading)
                    Text("10 - 20 Minutes")
                    Spacer()
                }
                .padding(.bottom)
                HStack {
                    Text("Lorem ipsum dolor sit amet,asdfasdfasdfasdfasdfas dasdfasdfasdfasdfasd fasdfasdf")
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                }
                .padding(.bottom)
                HStack {
                    Text("Ingredients")
                        .font(Font.title2.weight(.bold))
                        .padding(.leading)
                    Spacer()
                }
                IngredientsGridView()
                    .padding(.bottom)
                
                HStack {
                    Text("Utensils")
                        .font(Font.title2.weight(.bold))
                        .padding(.leading)
                    Spacer()
                }
                UtensilsGridView()
                    .padding(.bottom)
                
                HStack {
                    Text("Steps")
                        .font(Font.title2.weight(.bold))
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
                StepsView(steps: steps)
                    .padding(.bottom)
            }
            
            Button(action: {
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
    }
}

struct RecipePageView_Previews: PreviewProvider {
    static var previews: some View {
        RecipePageView(steps: StepByStep.SAMPLEDATA)
    }
}






//            Button("Let's Cook") {
//                print("Button pressed")
//            }
//            .padding(.horizontal)
//            .background(Color(red: 246/255, green: 200/255, blue: 79/255))
//            .foregroundStyle(.black)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
