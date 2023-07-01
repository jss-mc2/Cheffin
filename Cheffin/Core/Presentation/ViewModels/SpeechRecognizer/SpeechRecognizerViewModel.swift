//
//  SpeechRecognizerViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import Speech
import Dispatch

class SpeechRecognizerViewModel: ObservableObject {
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask? {
        didSet {
            // task can be nil, is not cancelled, cancelled
            if let task, !task.isCancelled {
                isTranscribing = true
                return
            }
            
            isTranscribing = false
        }
    }
    private var recognizer: SFSpeechRecognizer?
    
    /**
     SFSpeechRecognizer call recognitionHandler multiple times to get best transcription.
     debouncer is to only process the last recognitionHandler after 0.5 second
     */
    private var debouncer: DispatchWorkItem?
    
    @Published var isTranscribing = false
    @Published var transcript = ""
    
    /**
     Initializes a new speech recognizer. If this is the first time you've used the class, it
     requests access to the speech recognizer and the microphone.
     */
    func initSpeechRecognizer() {
        recognizer = SFSpeechRecognizer()
        guard recognizer != nil else {
            handleError(RecognizerError.nilRecognizer)
            return
        }
        
        Task {
            do {
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    /**
     destroy if you have no intention of resuming transcriber
     */
    func destroyTranscriber() {
        reset()
        recognizer = nil
        
        AVAudioSession.preferBluetoothOutput()
    }
    
    func stopTranscribing() {
        reset()
    }
    
    func restartTranscribing() {
        reset()
        startTranscribing()
    }
    
    /**
     Begin transcribing audio.
     
     Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopTranscribing()`.
     */
    func startTranscribing() {
        print("\(#function)")
        
        guard let recognizer, recognizer.isAvailable else {
            self.handleError(RecognizerError.recognizerIsUnavailable)
            return
        }
        
        do {
            let (audioEngine, request) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            self.task = recognizer.recognitionTask(with: request) { [weak self] result, error in
                self?.recognitionHandler(audioEngine: audioEngine, result: result, error: error)
            }
        } catch {
            self.reset()
            self.handleError(error)
        }
    }

    /// Reset the speech recognizer.
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
        transcript = ""
    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, _) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }

    private func recognitionHandler(
        audioEngine: AVAudioEngine, result: SFSpeechRecognitionResult?, error: Error?
    ) {
        print("\(#function)")
        
        // code 216 if user stopTranscribing()
        if let speechError = error as NSError?, speechError.code == 216 {
            return
        }
        
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        // receivedFinalResult if no incoming audio after some time.
        // receivedError if no incoming audio from the beginning.
        if receivedFinalResult || receivedError {
            if receivedFinalResult {
#if DEBUG
                print("\(#function) final")
#endif
            } else if receivedError {
#if DEBUG
                print("\(#function) error: " + (error?.localizedDescription ?? ""))
#endif
            }
            restartTranscribing()
            return
        }
        
        if let result {
            // cancel any previously scheduled debouncer
            debouncer?.cancel()
            
            let debounceTime = 0.5 // 0.5s
            
            let debouncer = DispatchWorkItem {
                print("\(#function) debouncing")
                if let transcribe = self.transcribe {
                    transcribe(result.bestTranscription.formattedString)
                }
            }
            
            self.debouncer = debouncer
            
            DispatchQueue.main.asyncAfter(deadline: .now() + debounceTime, execute: debouncer)
        }
    }
    
    var transcribe: ((_ message: String) -> Void)?
    
    // TODO: handle error
    func handleError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        print("\(#function) \(errorMessage) ")
    }
}
