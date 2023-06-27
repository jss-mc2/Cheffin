//
//  TimerViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import Foundation

class TimerViewModel: ObservableObject {
    let defaultCountDownTime: TimeInterval?
    
    private var userSetCountDownTime: TimeInterval? {
        didSet {
            if let userSetCountDownTime {
                displayedCountDownTime = TimeInterval.FORMATTER.string(from: userSetCountDownTime) ?? "0"
            }
        }
    }
    
    @Published var displayedCountDownTime: String?
    
    private var timer: Timer?
    private var endTime: Date?
    
    var execute: () -> Void
    
    /**
     - Parameter execute: executes after timer ends
     */
    init(_ defaultCountDownTime: TimeInterval? = nil, execute: @escaping () -> Void) {
        self.defaultCountDownTime = defaultCountDownTime
        if let defaultCountDownTime {
            self.displayedCountDownTime = TimeInterval.FORMATTER.string(from: defaultCountDownTime)
        }
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
#if DEBUG
        print("\(#function)")
#endif
        guard let countDownTime = userSetCountDownTime ?? defaultCountDownTime else {
            return
        }
        endTime = Date().addingTimeInterval(countDownTime)
        displayedCountDownTime = TimeInterval.FORMATTER.string(from: countDownTime) ?? ""
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateDisplayedCountDownTime()
        }
    }
    
    private func updateDisplayedCountDownTime() {
#if DEBUG
        print("\(#function)")
#endif
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
#if DEBUG
        print("\(#function)")
#endif
        if timer == nil {
            print("\(#function) timer is nil, this is not supposed to happen")
            return
        }
        timer?.invalidate()
        timer = nil
        endTime = nil
    }
}
