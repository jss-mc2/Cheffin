//
//  ButtonHighlightHiddenViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import Foundation

class ButtonHighlightHiddenViewModel: ObservableObject {
    let key: String
    
    let name: String
    @Published var isHighlighted = false {
        didSet {
            if isHighlighted {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isHighlighted = false
                }
                
                onHighlighted()
            }
        }
    }
    @Published var isHidden: Bool
    
    var onHighlighted: () -> Void
    
    /**
     - Parameters:
        - key: expected value: "set timer"
        - name: expected value: "set timer 1 minutes"
     */
    init(
        key: String? = nil,
        name: String,
        isHidden: Bool,
        onHighlighted: @escaping () -> Void
    ) {
        if let key {
            self.key = key
        } else {
            self.key = name
        }
        self.name = name
        self.isHidden = isHidden
        self.onHighlighted = onHighlighted
    }
}
