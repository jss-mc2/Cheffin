//
//  TextToSpeech.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/07/23.
//

import Speech

class TextToSpeech: NSObject, AVSpeechSynthesizerDelegate {
    private let voice: AVSpeechSynthesisVoice?
    private let synthesizer: AVSpeechSynthesizer?
    
    private var debouncer: DispatchWorkItem?
    
    private var before: (() -> Void)?
    private var completion: (() -> Void)?
    
    override init() {
        // Retrieve the default voice for the user's locale.
        voice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode())
        
        // Create a speech synthesizer.
        synthesizer = AVSpeechSynthesizer()
        
        super.init()
        
        synthesizer?.delegate = self
    }
    
    public func speak(before: (() -> Void)? = nil, string: String, completion: (() -> Void)? = nil) {
        // cancel any previously scheduled debouncer
        debouncer?.cancel()
        
        let debounceTime = 0.5 // 0.5s
        
        let debouncer = DispatchWorkItem {
            print("\(#function) debouncing")
            
            self.before = before
            
            // Create an utterance.
            let utterance = AVSpeechUtterance(string: string)

            // Adjust the rate to make the speech slower.
            utterance.rate = 0.4
            
            // Adjust the pitch to make the speech sound more natural.
            utterance.pitchMultiplier = 1.0
            
            // Set a short pause after each utterance for a more natural speech pattern.
            utterance.postUtteranceDelay = 0.5
            
            // Set the volume to a comfortable level.
            utterance.volume = 1.0
            
            // Assign the voice to the utterance.
            utterance.voice = self.voice
            
            self.completion = completion
            
            self.synthesizer?.speak(utterance)
        }
        
        self.debouncer = debouncer
        
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceTime, execute: debouncer)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        before?()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        completion?()
    }
}
