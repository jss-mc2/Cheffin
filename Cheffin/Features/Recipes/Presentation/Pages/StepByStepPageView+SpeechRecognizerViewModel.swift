//
//  StepByStepPageView+SpeechRecognizerViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import Foundation

extension StepByStepPageView {
    
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
                    case "read the text":
                        executeCommonAction(for: lastThreeWords)
                    default:
                        break
                    }
                }
            }
        }
        
        let maxLength = 4
        if words.count > maxLength {
            speechRecognizerViewModel.restartTranscribing()
            return
        }
        
        speechRecognizerViewModel.transcript = message
    }
    
    private func executeCommonAction(for action: String) {
        switch action {
        case "next", "next page", "next step":
            _ = pageViewModel.nextPage()
        case "previous", "previous page", "previous step":
            _ = pageViewModel.previousPage()
        case "repeat", "read the text":
            // TODO: speak
            break
        case "start timer":
            timerViewModel.startTimer()
        case "stop timer":
            timerViewModel.stopTimer()
        case "stop alarm":
            timerViewModel.stopAlarm()
        default:
            break
        }
        
        speechRecognizerViewModel.restartTranscribing()
    }
    
    private func executeSetTimerAction(for words: [String]) {
        let countDownDuration = transcribeTime(words)
        timerViewModel.setTimer(countDownDuration)
        speechRecognizerViewModel.restartTranscribing()
    }
    
    internal func toggleTranscribing() {
        if !speechRecognizerViewModel.isTranscribing {
            speechRecognizerViewModel.initSpeechRecognizer()
            speechRecognizerViewModel.transcribe = transcribeNavigation
            speechRecognizerViewModel.startTranscribing()
        } else {
            stopTranscribing()
        }
    }
    
    internal func stopTranscribing() {
        speechRecognizerViewModel.stopTranscribing()
    }
}
