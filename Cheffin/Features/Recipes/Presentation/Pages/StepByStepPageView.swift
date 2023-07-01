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
    
    @Environment(\.dismiss)
    private var dismiss
    
    init(_ steps: [StepByStep]) {
        self._viewModel = StateObject(wrappedValue: StepByStepPageViewModel(steps: steps))
    }
    
    var body: some View {
        ZStack {
            
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
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button("Done") {
                        dismiss()
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 24))
        }
        // TODO: tech debt hack to allow onTapGesture on empty view.
        .background(.blue.opacity(0.0001))
        .onTapGesture { location in
            if location.x > UIScreen.main.bounds.width / 2 {
                _ = viewModel.pager.nextPage()
            } else {
                _ = viewModel.pager.previousPage()
            }
        }
        .onAppear {
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
