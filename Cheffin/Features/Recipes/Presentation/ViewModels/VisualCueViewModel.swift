//
//  VisualCueViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

class VisualCueViewModel: ObservableObject {
    var buttonHighlightVM: [String: ButtonHighlightViewModel] = [:]
    
    init(buttonHighlightVM: [String: ButtonHighlightViewModel]) {
        self.buttonHighlightVM = buttonHighlightVM
    }
}
