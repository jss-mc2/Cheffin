//
//  StepByStepView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import SwiftUI
import AVKit

// TODO: StepByStepView
struct StepByStepView: View {
    let step: StepByStep
    
    init(_ step: StepByStep) {
        self.step = step
        print("\(type(of: self)) \(#function)")
    }
    
    var body: some View {
        VStack {
            if step.mediaType == .photo {
                AsyncImage(url: URL(string: step.media)) { image in
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(I.primary.swiftUIColor)
                            .aspectRatio(1, contentMode: .fit)
                        ProgressView()
                            .background(I.primary.swiftUIColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .scaleEffect(3.0)
                    }
                }
                .padding(EdgeInsets(.init(top: -8, leading: 0, bottom: 24, trailing: 0)))
            } else if step.mediaType == .gif {
                // TODO: handle GIF image
            } else if step.mediaType == .video {
                PlayerView(mediaUrl: step.media)
                    .padding(EdgeInsets(.init(top: -8, leading: 0, bottom: 24, trailing: 0)))
            }
            
            StepByStepDescriptionView(step.instruction)
        }
    }
}

struct StepByStepView_Previews: PreviewProvider {
    static var previews: some View {
        StepByStepView(StepByStep.SAMPLEDATA[0])
    }
}
