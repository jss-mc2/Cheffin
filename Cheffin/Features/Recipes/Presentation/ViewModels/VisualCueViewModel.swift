//
//  VisualCueViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

enum VisualCueKey {
    case next, previous,
         readTheText,
         setTimer, startTimer, stopTimer,
         stopAlarm
}

class VisualCueViewModel: ObservableObject {
    var buttonHighlightVM: [VisualCueKey: ButtonHighlightViewModel] = [:]
    
    init() {
        buttonHighlightVM[.next] = ButtonHighlightViewModel(label: "next")
        buttonHighlightVM[.previous] = ButtonHighlightViewModel(label: "previous")
        
        buttonHighlightVM[.readTheText] = ButtonHighlightViewModel(label: "repeat")
        
        buttonHighlightVM[.setTimer] = ButtonHighlightViewModel(label: "set timer ... minutes")
        buttonHighlightVM[.startTimer] = ButtonHighlightViewModel(label: "start timer")
        buttonHighlightVM[.stopTimer] = ButtonHighlightViewModel(label: "stop timer")
        
        buttonHighlightVM[.stopAlarm] = ButtonHighlightViewModel(label: "stop alarm")
    }
}
