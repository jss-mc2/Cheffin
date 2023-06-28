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
            Text(step.title)
            AsyncImage(url: URL(string: step.media))
            Text(step.instruction)
        }
    }
}

struct StepByStepView_Previews: PreviewProvider {
    static var previews: some View {
        StepByStepView(StepByStep.SAMPLEDATA[0])
    }
}
