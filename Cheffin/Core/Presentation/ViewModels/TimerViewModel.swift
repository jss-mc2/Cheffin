//
//  TimerViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import Foundation
import AVFoundation

class TimerViewModel: ObservableObject {
    let defaultCountDownTime: TimeInterval?
    
    private var userSetCountDownTime: TimeInterval? {
        didSet {
            guard let userSetCountDownTime else {
                displayedCountDownTime = nil
                return
            }
            displayedCountDownTime = TimeInterval.FORMATTER.string(from: userSetCountDownTime)
        }
    }
    
    @Published var displayedCountDownTime: String?
    
    @Published var timer: Timer?
    private var endTime: Date?
    
    var onStartTimer: () -> Void
    var onTimerEnd: () -> Void
    @Published var isPlayAlert = false
    
    /**
     - Parameter execute: executes after timer ends
     */
    init(_ defaultCountDownTime: TimeInterval? = nil, onStartTimer: @escaping () -> Void = {}, onTimerEnd: @escaping () -> Void = {}) {
        self.defaultCountDownTime = defaultCountDownTime
        if let defaultCountDownTime {
            self.displayedCountDownTime = TimeInterval.FORMATTER.string(from: defaultCountDownTime)
        }
        self.onStartTimer = onStartTimer
        self.onTimerEnd = onTimerEnd
    }
    
    /**
     - Important: if timer is running, it will stop timer.
     */
    func setTimer(_ countDownTime: TimeInterval? = nil) {
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
    
    func toggleAlarm() {
        if isPlayAlert {
            stopAlarm()
        } else {
            startAlarm()
        }
    }
    
    func startAlarm() {
        self.isPlayAlert = true
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1304)) {
            if self.isPlayAlert == true {
                self.startAlarm()
            }
        }
    }
    
    func stopAlarm() {
        self.isPlayAlert = false
    }
    
    func startTimer() {
#if DEBUG
        print("\(#function)")
#endif
        onStartTimer()
        
        stopTimer()
        stopAlarm()
        
        guard let countDownTime = userSetCountDownTime ?? defaultCountDownTime else {
            return
        }
        endTime = Date().addingTimeInterval(countDownTime)
        displayedCountDownTime = TimeInterval.FORMATTER.string(from: countDownTime)
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
        displayedCountDownTime = elapsedTime >= 0 ? TimeInterval.FORMATTER.string(from: elapsedTime) : "0"
        
        if displayedCountDownTime == "0" {
            stopTimer()
            onTimerEnd()
            
            startAlarm()
        }
    }
    
    func stopTimer() {
#if DEBUG
        print("\(#function)")
#endif
        timer?.invalidate()
        timer = nil
        endTime = nil
        if let countDownTime = userSetCountDownTime ?? defaultCountDownTime {
            displayedCountDownTime = TimeInterval.FORMATTER.string(from: countDownTime)
        }
    }
}
