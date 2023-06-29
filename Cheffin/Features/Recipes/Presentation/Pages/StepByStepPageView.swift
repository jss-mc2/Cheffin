//
//  StepByStepView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI
import AVFoundation

struct StepByStepPageView: View {
    let steps: [StepByStep]
    
    @StateObject var timerViewModel: TimerViewModel
    @StateObject var pageViewModel: PageViewModel<StepByStepView>
    
    var buttonStates: [ButtonHighlightHiddenViewModel] = []
    
    init(_ steps: [StepByStep]) {
        self.steps = steps
        
        var tempButtonStates: [ButtonHighlightHiddenViewModel] = []
        
        let tempTimerViewModel = TimerViewModel(
            onStartTimer: {
                tempButtonStates.first { $0.key == "start timer" }?.isHidden = true
                tempButtonStates.first { $0.key == "set timer" }?.isHidden = true
                tempButtonStates.first { $0.key == "stop timer" }?.isHidden = false
            },
            onTimerEnd: {
                tempButtonStates.first { $0.key == "stop alarm" }?.isHidden = false
            }
        )
        
        let tempPageViewModel = PageViewModel(steps.map { step in StepByStepView(step) })
        tempButtonStates.append(
            ButtonHighlightHiddenViewModel(name: "next", isHidden: false) {
                if !tempPageViewModel.nextPage() {
                    // TODO: bon apetit page
                }
            }
        )
        tempButtonStates.append(
            ButtonHighlightHiddenViewModel(name: "back", isHidden: false) {
                if !tempPageViewModel.previousPage() {
                    // TODO: recipe page
                }
            }
        )
        tempButtonStates.append(
            ButtonHighlightHiddenViewModel(name: "repeat", isHidden: false) {
                // TODO: repeat
            }
        )
        tempButtonStates.append(
            ButtonHighlightHiddenViewModel(key: "set timer", name: "set timer ... minutes", isHidden: true) {
                tempTimerViewModel.setTimer(5)
                tempButtonStates.first { $0.key == "start timer" }?.isHidden = false
                tempButtonStates.first { $0.key == "stop timer" }?.isHidden = true
            }
        )
        tempButtonStates.append(
            ButtonHighlightHiddenViewModel(name: "start timer", isHidden: true) {
                tempTimerViewModel.startTimer()
                tempButtonStates.first { $0.key == "set timer" }?.isHidden = true
                tempButtonStates.first { $0.key == "start timer" }?.isHidden = true
                tempButtonStates.first { $0.key == "stop timer" }?.isHidden = false
            }
        )
        tempButtonStates.append(
            ButtonHighlightHiddenViewModel(name: "stop timer", isHidden: true) {
                tempTimerViewModel.stopTimer()
                tempButtonStates.first { $0.key == "start timer" }?.isHidden = false
                tempButtonStates.first { $0.key == "set timer" }?.isHidden = false
                tempButtonStates.first { $0.key == "stop timer" }?.isHidden = true
            }
        )
        tempButtonStates.append(
            ButtonHighlightHiddenViewModel(name: "stop alarm", isHidden: true) {
                tempTimerViewModel.stopAlarm()
                tempButtonStates.first { $0.key == "stop alarm" }?.isHidden = true
            }
        )
        
        self._timerViewModel = StateObject(wrappedValue: tempTimerViewModel)
        self._pageViewModel = StateObject(wrappedValue: tempPageViewModel)
        self.buttonStates = tempButtonStates
    }
    
    var body: some View {
        VStack {
//            Button(
//                action: {
//                    _ = pageViewModel.nextPage()
//                },
//                label: {
//                    Text("next")
//                }
//            )
//            Button(
//                action: {
//                    _ = pageViewModel.previousPage()
//                },
//                label: {
//                    Text("back")
//                }
//            )
            Text(steps[pageViewModel.currentPage].title)
                .font(.system(.title2, weight: .semibold))
                .padding(.top, 32)
            ZStack {
                ProgressView(
                    value: Double(pageViewModel.currentPage + 1),
                    total: Double(pageViewModel.pages.count)
                )
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(.accentColor)
                    .scaleEffect(CGSize(width: 1.1, height: 7.0))
                Text("\(pageViewModel.currentPage + 1) of \(pageViewModel.pages.count)")
            }
            pageViewModel.pages[pageViewModel.currentPage]
            Spacer()
//            Button(
//                action: {
//                    timerViewModel.toggleAlarm()
//                },
//                label: {
//                    Text("Toggle alarm")
//                }
//            )
//            Button(
//                action: {
//                    buttonStates.first { $0.key == "set timer" }?.isHidden.toggle()
//                },
//                label: {
//                    Text("Toggle set timer isHidden variable")
//                }
//            )
            TimerView(timerViewModel)
            SpeechRecognizerView(buttonStates.map { state in
                ButtonHighlightHiddenView(state: state)
            })
            .padding(.bottom, 32)
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
