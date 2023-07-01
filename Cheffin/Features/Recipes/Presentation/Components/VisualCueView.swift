//
//  VisualCueView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

struct VisualCueView<Page: View>: View {
    let steps: [StepByStep]
    
    @ObservedObject var viewModel: VisualCueViewModel
    @ObservedObject var pager: PageViewModel<Page>
    @ObservedObject var timer: TimerViewModel
    
    init(viewModel: VisualCueViewModel, steps: [StepByStep], pager: PageViewModel<Page>, timer: TimerViewModel) {
        self.viewModel = viewModel
        self.steps = steps
        self.pager = pager
        self.timer = timer
        
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mic.fill").foregroundColor(I.accentColor.swiftUIColor)
                let textResponsive = Text("try saying:").italic()
                    
                if UIDevice.current.userInterfaceIdiom == .phone {
                    textResponsive.font(.body).fontWeight(.regular)
                } else if UIDevice.current.userInterfaceIdiom == .pad {
                    textResponsive.font(.title2).fontWeight(.regular)
                }
            }
            WrappingHStack(alignment: .center) {
                ButtonHighlight(viewModel: viewModel.buttonHighlightVM[.previous]!)
    
                ButtonHighlight(viewModel: viewModel.buttonHighlightVM[.next]!)
    
                ButtonHighlight(viewModel: viewModel.buttonHighlightVM[.readTheText]!)
    
                if timer.displayedCountDownTime != nil {
                    if timer.timer == nil {
                        ButtonHighlight(viewModel: viewModel.buttonHighlightVM[.setTimer]!)
                        
                        ButtonHighlight(viewModel: viewModel.buttonHighlightVM[.startTimer]!)
                    }
                    
                    if timer.timer != nil {
                        ButtonHighlight(viewModel: viewModel.buttonHighlightVM[.stopTimer]!)
                    }
                    
                    if timer.isPlayAlert {
                        ButtonHighlight(viewModel: viewModel.buttonHighlightVM[.stopAlarm]!)
                    }
                }
            }
            .font(.system(.title))
        }
        .onAppear {
#if DEBUG
            print("\(type(of: self)) \(#function) appeared")
#endif
        }
        .onDisappear {
#if DEBUG
            print("\(type(of: self)) \(#function) disappeared")
#endif
        }
    }
}
