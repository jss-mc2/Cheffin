//
//  StepByStepPageViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

class StepByStepPageViewModel: ObservableObject {
    let steps: [StepByStep]
    
    var speechRecognizer = SpeechRecognizerViewModel()
    var textToSpeech: TextToSpeech
    
    var buttonHighlightVM: [String: ButtonHighlightViewModel] = [:]
    var visualCuer: VisualCueViewModel
    
    var timer: TimerViewModel
    var pager: PageViewModel<StepByStepView>
    
    init(steps: [StepByStep]) {
        self.steps = steps
        
        let tempTimer = TimerViewModel(
            onStartTimer: {},
            onTimerEnd: {}
        )
        let tempPager = PageViewModel(steps.map { step in StepByStepView(step) })
        let tempTextToSpeech = TextToSpeech()
        
        buttonHighlightVM["next"] = ButtonHighlightViewModel(
            action: {
                _ = tempPager.nextPage()
                tempTimer.setTimer(steps[tempPager.currentPage].timer)
            },
            label: "next"
        )
        buttonHighlightVM["previous"] = ButtonHighlightViewModel(
            action: {
                _ = tempPager.previousPage()
                tempTimer.setTimer(steps[tempPager.currentPage].timer)
            },
            label: "previous"
        )
        buttonHighlightVM["repeat"] = ButtonHighlightViewModel(
            action: {
              // TODO
                tempTextToSpeech.speak(string: steps[tempPager.currentPage].instruction)
            },
            label: "repeat"
        )
        buttonHighlightVM["set timer"] = ButtonHighlightViewModel(label: "set timer ... minutes")
        buttonHighlightVM["start timer"] = ButtonHighlightViewModel(
            action: {
                tempTimer.startTimer()
            },
            label: "start timer"
        )
        buttonHighlightVM["stop timer"] = ButtonHighlightViewModel(
            action: {
                tempTimer.stopTimer()
            },
            label: "stop timer"
        )
        buttonHighlightVM["stop alarm"] = ButtonHighlightViewModel(
            action: {
                tempTimer.stopAlarm()
            },
            label: "stop alarm"
        )
        
        self.visualCuer = VisualCueViewModel(buttonHighlightVM: buttonHighlightVM)
        
        self.timer = tempTimer
        self.pager = tempPager
        self.textToSpeech = tempTextToSpeech
    }
    
    /**
     - Parameters:
        - words: expected value
            - one hour 25 minutes 20 seconds
            - 1 hour 25 minute 20 second
     */
    internal func transcribeTime(_ words: [String]) -> TimeInterval {
        var timeInterval: TimeInterval = 0
        
        let convertedWords = words.map { word in
            return SpeechRecognizerViewModel.MAPPING[word] ?? word
        }
        
        for i in 0..<convertedWords.count - 1 {
            let value = convertedWords[i]
            let unit = convertedWords[i + 1]
            
#if DEBUG
            print(value, unit)
#endif
            if let intValue = Double(value) {
                switch unit {
                case "hour":
                    timeInterval += intValue * 3600
                case "minute":
                    timeInterval += intValue * 60
                case "second":
                    timeInterval += intValue
                default:
                    break
                }
            }
        }
        
        return timeInterval
    }
    
    private func transcribeNavigation(_ message: String) {
#if DEBUG
        print("\(#function) \(message)")
#endif
        
        let words = message
            .lowercased()
            .components(separatedBy: " ")
            .map { word in
                return SpeechRecognizerViewModel.MAPPING[word] ?? word
            }
        
        if let last = words.last {
            switch last {
            case "next", "previous", "repeat":
                executeCommonAction(for: last)
            case "hour", "minute", "second":
                executeSetTimerAction(for: words)
            default:
                let lastTwoWords = words.suffix(2).joined(separator: " ")
                switch lastTwoWords {
                case
                    "next page", "next step",
                    "previous page", "previous step",
                    "start timer", "stop timer",
                    "stop alarm"
                    :
                    executeCommonAction(for: lastTwoWords)
                case "hour timer", "minute timer", "second timer":
                    executeSetTimerAction(for: words)
                default:
                    let lastThreeWords = words.suffix(3).joined(separator: " ")
                    switch lastThreeWords {
                    case "read the text", "read my text":
                        executeCommonAction(for: lastThreeWords)
                    default:
                        break
                    }
                }
            }
        }
        
        let maxLength = 4
        if words.count > maxLength {
            speechRecognizer.restartTranscribing()
            return
        }
        
        speechRecognizer.transcript = message
    }
    
    private func executeCommonAction(for action: String) {
        switch action {
        case "next", "next page", "next step":
            let buttonHighlightVM = buttonHighlightVM["next"]!
            buttonHighlightVM.action()
            buttonHighlightVM.isHighlighted = true
        case "previous", "previous page", "previous step":
            let buttonHighlightVM = buttonHighlightVM["previous"]!
            buttonHighlightVM.action()
            buttonHighlightVM.isHighlighted = true
        case "repeat", "read the text", "read my text":
            let buttonHighlightVM = buttonHighlightVM["repeat"]!
            buttonHighlightVM.action()
            buttonHighlightVM.isHighlighted = true
        case "start timer":
            let buttonHighlightVM = buttonHighlightVM["start timer"]!
            buttonHighlightVM.action()
            buttonHighlightVM.isHighlighted = true
        case "stop timer":
            let buttonHighlightVM = buttonHighlightVM["stop timer"]!
            buttonHighlightVM.action()
            buttonHighlightVM.isHighlighted = true
        case "stop alarm":
            let buttonHighlightVM = buttonHighlightVM["stop alarm"]!
            buttonHighlightVM.action()
            buttonHighlightVM.isHighlighted = true
        default:
            break
        }
        
        speechRecognizer.restartTranscribing()
    }
    
    private func executeSetTimerAction(for words: [String]) {
        let countDownDuration = transcribeTime(words)
        let buttonHighlightVM = buttonHighlightVM["set timer"]!
        timer.setTimer(countDownDuration)
        buttonHighlightVM.isHighlighted = true
        speechRecognizer.restartTranscribing()
    }
    
    func toggleTranscribing() {
        if !speechRecognizer.isTranscribing {
            startTranscribing()
        } else {
            stopTranscribing()
        }
    }
    
    internal func startTranscribing() {
        speechRecognizer.initSpeechRecognizer()
        speechRecognizer.transcribe = transcribeNavigation
        speechRecognizer.startTranscribing()
    }
    
    internal func stopTranscribing() {
        speechRecognizer.stopTranscribing()
    }
}
