//
//  TimerView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var state: TimerViewModel
    
    init(_ timerViewModel: TimerViewModel) {
        self.state = timerViewModel
    }
    
    var body: some View {
        Group {
            if let displayedCountDownTime = state.displayedCountDownTime {
                Button(
                    action: {
                        state.toggleTimer()
                    },
                    label: {
                        HStack {
                            Image(systemName: "stopwatch")
                                .foregroundColor(.black)
                                .bold()
                            Text(displayedCountDownTime)
                                .foregroundColor(.black)
                                .bold()
                        }
                        .padding(12)
                        .background(I.primary.swiftUIColor)
                        .cornerRadius(10)
                    }
                )
            } else {
                EmptyView()
            }
        }
    }
}

#if DEBUG
struct TimerViewPreviews: View {
    @ObservedObject var timerViewModel = TimerViewModel(5)
    
    var body: some View {
        VStack {
            Button(
                action: {
                    timerViewModel.setTimer(3)
                },
                label: {
                    Text("Set timer to 3 seconds")
                }
            )
            TimerView(timerViewModel)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerViewPreviews()
    }
}
#endif
