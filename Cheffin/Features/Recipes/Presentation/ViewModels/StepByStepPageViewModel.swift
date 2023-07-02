//
//  StepByStepPageViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI
import AVFAudio

class StepByStepPageViewModel: ObservableObject {
    let steps: [StepByStep]
    
    var speechRecognizer: SpeechRecognizerViewModel
    var textToSpeech: TextToSpeech

    var visualCuer: VisualCueViewModel
    
    var timer: TimerViewModel
    var pager: PageViewModel<StepByStepView>
    
    init(steps: [StepByStep]) {
        self.steps = steps
        
        let tempPager = PageViewModel(steps.map { step in StepByStepView(step) })
        let tempSpeechRecognizer = SpeechRecognizerViewModel()
        let tempTextToSpeech = TextToSpeech()
        let tempTimer = TimerViewModel(
            onStartTimer: {},
            onTimerEnd: {
                AVAudioSession.preferSpeakerOutput()
            }
        )
        
        let tempVisualCuer = VisualCueViewModel()
        
        tempVisualCuer.buttonHighlightVM[.readTheText]?.action = {
            let delimiters: [Character] = ["[", "]", "{", "}", "<", ">"]
            let cleanedWords = String.removeDelimiters(
                steps[tempPager.currentPage].instruction,
                delimiters: delimiters
            )
            
            tempTextToSpeech.speak(
                before: { tempSpeechRecognizer.destroyTranscriber() },
                string: cleanedWords,
                completion: {
                    tempSpeechRecognizer.initSpeechRecognizer()
                    tempSpeechRecognizer.startTranscribing()
                }
            )
        }
        
        tempVisualCuer.buttonHighlightVM[.startTimer]?.action = { tempTimer.startTimer() }
        
        tempVisualCuer.buttonHighlightVM[.stopTimer]?.action = { tempTimer.stopTimer() }
        
        tempVisualCuer.buttonHighlightVM[.stopAlarm]?.action = { tempTimer.stopAlarm() }
        
        self.visualCuer = tempVisualCuer
        
        self.timer = tempTimer
        self.pager = tempPager
        self.textToSpeech = tempTextToSpeech
        self.speechRecognizer = tempSpeechRecognizer
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
                    let lastFourWords = words.suffix(4)
                    if lastFourWords.indices.contains(3) {
                        switch lastFourWords.prefix(3) {
                        case ["go", "to", "page"]:
                            if let intValue = Int(lastFourWords[3]) {
                                if pager.goToPage(intValue) {
                                    if let button = visualCuer.buttonHighlightVM[.readTheText] {
                                        button.action()
                                        button.isHighlighted = true
                                    }
                                }
                            }
                            
                            speechRecognizer.restartTranscribing()
                        default:
                            break
                        }
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
        func performAction(_ state: ButtonHighlightViewModel?) {
            guard let state else {
                return
            }
            state.action()
            state.isHighlighted = true
        }
        
        switch action {
        case "next", "next page", "next step":
            let state = visualCuer.buttonHighlightVM[.next]
            performAction(state)
        case "previous", "previous page", "previous step":
            let state = visualCuer.buttonHighlightVM[.previous]
            performAction(state)
        case "repeat", "read the text", "read my text":
            let state = visualCuer.buttonHighlightVM[.readTheText]
            performAction(state)
        case "start timer":
            let state = visualCuer.buttonHighlightVM[.startTimer]
            performAction(state)
        case "stop timer":
            let state = visualCuer.buttonHighlightVM[.stopTimer]
            performAction(state)
        case "stop alarm":
            let state = visualCuer.buttonHighlightVM[.stopAlarm]
            performAction(state)
        default:
            break
        }
        
        speechRecognizer.restartTranscribing()
    }
    
    private func executeSetTimerAction(for words: [String]) {
        let countDownDuration = transcribeTime(words)
        speechRecognizer.restartTranscribing()
        
        if countDownDuration == 0 {
            return
        }
        
        timer.setTimer(countDownDuration)
        
        if let state = visualCuer.buttonHighlightVM[.setTimer] {
            state.isHighlighted = true
        }
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
