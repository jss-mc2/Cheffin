//
//  StepsView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI


struct Step: Identifiable {
    
    let id = UUID()
    let order: Int
    let step: String
}


struct StepsView: View {
    
    let steps: [StepByStep]
    
    
    var body: some View {
        ForEach(steps) { item in
            HStack {
                Text(String(item.order))
                    .padding(.horizontal)
                    .font(Font.headline)
                Text(item.title)
                Spacer()
            }
        }
    }
}


struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView(steps: StepByStep.SAMPLEDATA)
    }
}
























//    let steps = [
//        Step(order: 1, step: "Cut red onion into slices"),
//        Step(order: 2, step: "Cut garlic into slices"),
//        Step(order: 3, step: "Cut carrot into slices"),
//        Step(order: 4, step: "Chop potato into dices"),
//        Step(order: 5, step: "Chop ginger"),
//        Step(order: 6, step: "Cut green beans"),
//        Step(order: 7, step: "Cut spring onion"),
//        Step(order: 8, step: "Cut chicken into slices"),
//        Step(order: 9, step: "Roast star anise and anise in a pot until fragrant"),
//        Step(order: 10, step: "Pour oil in the pan and sauté everything"),
//        Step(order: 11, step: "Put in ginger, garlic, and red onion. Then, sauté everything"),
//        Step(order: 12, step: "Put the chicken pieces in the pot"),
//        Step(order: 13, step: "Season with salt and black pepper to taste"),
//        Step(order: 14, step: "Pour 600ml of water to the pot and wait until it simmers"),
//        Step(order: 15, step: "Throw away the residue at the top of the water"),
//        Step(order: 16, step: "Pour another 1.2L of water"),
//        Step(order: 17, step: "Put the carrots and potatoes into the soup"),
//        Step(order: 18, step: "Season again to liking with salt,  black pepper, 4 chicken stock cubes, and shaved nutmeg"),
//        Step(order: 19, step: "Put the green beans into the soup and wait until it is cooked"),
//        Step(order: 20, step: "Put spring onion and celery into the soup")
//    ]




//                ZStack(alignment: .center) {
//                    HStack {
//                        Text(String(item.order))
//                            .padding(.horizontal)
//                            .padding(.bottom)
//                            .font(Font.headline)
//                        Text(item.step)
//                        Spacer()
//                    }
//                }
