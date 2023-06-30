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
