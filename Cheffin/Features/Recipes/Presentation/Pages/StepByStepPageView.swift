//
//  StepByStepView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI
import AVFoundation

struct StepByStepPageView: View {
    @StateObject var viewModel: StepByStepPageViewModel
    
    init(_ steps: [StepByStep]) {
        self._viewModel = StateObject(wrappedValue: StepByStepPageViewModel(steps: steps))
    }
    
    var body: some View {
        VStack {
            StepByStepTitleView(pager: viewModel.pager, steps: viewModel.steps)
            StepByStepProgressView(pager: viewModel.pager)
            PageView(pager: viewModel.pager)
            Spacer()
            TimerView(viewModel: viewModel.timer)
            VisualCueView(
                viewModel: viewModel.visualCuer,
                steps: viewModel.steps,
                pager: viewModel.pager,
                timer: viewModel.timer
            )
            .padding(.bottom, 32)
        }.onAppear {
            viewModel.timer.setTimer(viewModel.steps[0].timer)
            viewModel.startTranscribing()
        }
		.onDisappear {
			viewModel.stopTranscribing()
		}
    }
}

#if DEBUG
struct StepByStepPageViewPreviews: View {
    let steps: [StepByStep] = StepByStep.SAMPLEDATA
    
    var body: some View {
        StepByStepPageView(steps)
    }
}

struct StepByStepPageView_Previews: PreviewProvider {
    static var previews: some View {
        StepByStepPageViewPreviews()
    }
}
#endif
