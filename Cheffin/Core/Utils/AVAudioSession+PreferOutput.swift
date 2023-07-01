//
//  AVAudioSession+PreferSpeaker.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/07/23.
//

import AVFAudio

extension AVAudioSession {
    /**
     - Important: does not work if SFSpeechRecognizer is running.
     */
    static func preferBluetoothOutput() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.soloAmbient)
        } catch {
            print("\(type(of: self)) \(#function) fail to set AVAudioSession category")
        }
    }
    
    static func preferSpeakerOutput() {
        do {
            // TODO: play on bluetooth.
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        } catch {
            print("\(type(of: self)) \(#function) fail to set AVAudioSession category")
        }
    }
}
