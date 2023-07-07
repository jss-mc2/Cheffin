//
//  TimerView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if let displayedCountDownTime = viewModel.displayedCountDownTime {
                Button(
                    action: {
                        viewModel.toggleTimer()
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
    @ObservedObject var timer = TimerViewModel(5)
    
    var body: some View {
        VStack {
            Button(
                action: {
                    timer.setTimer(3)
                },
                label: {
                    Text("Set timer to 3 seconds")
                }
            )
            TimerView(viewModel: timer)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerViewPreviews()
    }
}
#endif
