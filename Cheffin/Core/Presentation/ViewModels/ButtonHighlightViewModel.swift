//
//  ButtonHighlightViewModel.swift
//  StateObjectExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import Foundation

class ButtonHighlightViewModel: ObservableObject {
    var action: () -> Void
    let label: String
    @Published var isHighlighted = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isHighlighted = false
            }
        }
    }
    
    init(action: @escaping () -> Void = {}, label: String) {
        self.action = action
        self.label = label
    }
}
