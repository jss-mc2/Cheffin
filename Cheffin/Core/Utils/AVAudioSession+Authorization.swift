//
//  AVAudioSession+HasPermissionToRecord.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import AVFAudio

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
