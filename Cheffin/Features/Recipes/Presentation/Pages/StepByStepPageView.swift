//
//  StepByStepView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI
import AVFoundation

struct StepByStepPageView: View {
    let controller: RecipeViewController
    @StateObject var viewModel: StepByStepPageViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    init(controller: RecipeViewController, steps: [StepByStep]) {
        self.controller = controller
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
                if viewModel.pager.endOfPage() {
                    dismiss() // dismiss StepByStepPageView, magic is it?
                    controller.navigateToFinish()
                } else {
                    if let button = viewModel.visualCuer.buttonHighlightVM[.next] {
                        button.action()
                        button.isHighlighted = true
                    }
                }
            } else {
                if viewModel.pager.beginningOfPage() {
                    print("hello")
                    dismiss()
                } else {
                    if let button = viewModel.visualCuer.buttonHighlightVM[.previous] {
                        button.action()
                        button.isHighlighted = true
                    }
                }
            }
        }
        .onAppear {
            viewModel.timer.setTimer(viewModel.steps[0].timer)
            viewModel.startTranscribing()
            if let button = viewModel.visualCuer.buttonHighlightVM[.readTheText] {
                button.action()
                button.isHighlighted = true
            }
            
            viewModel.visualCuer.buttonHighlightVM[.next]?.action = {
                if viewModel.pager.endOfPage() {
                    viewModel.timer.stopAlarm()
                    dismiss()
                    controller.navigateToFinish()
                } else {
                    _ = viewModel.pager.nextPage()
                    if let button = viewModel.visualCuer.buttonHighlightVM[.readTheText] {
                        button.action()
                        button.isHighlighted = true
                    }
                }
                viewModel.timer.setTimer(viewModel.steps[viewModel.pager.currentPage].timer)
            }
            
            viewModel.visualCuer.buttonHighlightVM[.previous]?.action = {
                if viewModel.pager.beginningOfPage() {
                    dismiss()
                } else {
                    _ = viewModel.pager.previousPage()
                }
                viewModel.timer.setTimer(viewModel.steps[viewModel.pager.currentPage].timer)
            }
        }
		.onDisappear {
			viewModel.stopTranscribing()
		}
    }
}
