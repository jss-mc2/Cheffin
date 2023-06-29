//
//  StepByStepView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import SwiftUI

// TODO: StepByStepView
struct StepByStepView: View {
    let step: StepByStep
    
    init(_ step: StepByStep) {
        self.step = step
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: step.media)) { image in
                image
                    .resizable()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height * (1 / 3)
                    )
                    .scaledToFit()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(I.primary.swiftUIColor)
                        .frame(height: UIScreen.main.bounds.height * (1 / 3))
                    ProgressView()
                        .background(I.primary.swiftUIColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .scaleEffect(5.0)
                }
            }
            .padding(EdgeInsets(.init(top: -8, leading: 0, bottom: 24, trailing: 0)))
            Text(step.instruction)
                .font(.system(.largeTitle, weight: .bold))
        }
    }
}

struct StepByStepView_Previews: PreviewProvider {
    static var previews: some View {
        StepByStepView(StepByStep.SAMPLEDATA[0])
    }
}
