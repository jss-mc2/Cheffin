//
//  TimerView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    let defaultCountDownTime: TimeInterval
    
    private var userSetCountDownTime: TimeInterval? {
        didSet {
            if let userSetCountDownTime {
                displayedCountDownTime = TimeInterval.FORMATTER.string(from: userSetCountDownTime) ?? "0"
            }
        }
    }
    
    @Published var displayedCountDownTime: String
    
    private var timer: Timer?
    private var endTime: Date?
    
    var execute: () -> Void
    
    /**
     - Parameter execute: executes after timer ends
     */
    init(_ defaultCountDownTime: TimeInterval, execute: @escaping () -> Void) {
        self.defaultCountDownTime = defaultCountDownTime
        self.displayedCountDownTime = TimeInterval.FORMATTER.string(from: defaultCountDownTime) ?? "0"
        self.execute = execute
    }
    
    func setTimer(_ countDownTime: TimeInterval) {
        if timer != nil {
            stopTimer()
        }
        userSetCountDownTime = countDownTime
    }
    
    func toggleTimer() {
        if timer != nil {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        print("\(#function)")
        let countDownTime = userSetCountDownTime ?? defaultCountDownTime
        endTime = Date().addingTimeInterval(countDownTime)
        displayedCountDownTime = TimeInterval.FORMATTER.string(from: countDownTime) ?? ""
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateDisplayedCountDownTime()
        }
    }
    
    private func updateDisplayedCountDownTime() {
        print("\(#function) \(displayedCountDownTime)")
        guard let endTime else {
            stopTimer()
            print("\(#function) endTime is nil, this is not supposed to happen")
            return
        }
        
        // expected elapsedTime: 60 -> 59 -> 58 ...
        let elapsedTime = endTime.timeIntervalSince(Date()).rounded()
        displayedCountDownTime = elapsedTime >= 0 ? (TimeInterval.FORMATTER.string(from: elapsedTime) ?? "0") : "0"
        
        if displayedCountDownTime == "0" {
            stopTimer()
            execute()
        }
    }
    
    private func stopTimer() {
        print("\(#function)")
        if timer == nil {
            print("\(#function) timer is nil, this is not supposed to happen")
            return
        }
        timer?.invalidate()
        timer = nil
        endTime = nil
    }
}

struct TimerView: View {
    @ObservedObject var state: TimerViewModel
    
    init(_ timerViewModel: TimerViewModel) {
        self.state = timerViewModel
    }
    
    var body: some View {
        Button(
            action: {
                state.toggleTimer()
            },
            label: {
                HStack {
                    Image(systemName: "stopwatch")
                        .foregroundColor(.black)
                        .bold()
                    Text(state.displayedCountDownTime)
                        .foregroundColor(.black)
                        .bold()
                }
                .padding(12)
                .background(I.primary.swiftUIColor)
                .cornerRadius(10)
            }
        )
    }
}

#if DEBUG
struct TimerViewPreviews: View {
    @ObservedObject var timerViewModel = TimerViewModel(5) {
        print("\(#function) do something")
    }
    
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
