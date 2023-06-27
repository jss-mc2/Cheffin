//
//  ButtonHighlightHiddenViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import Foundation

class ButtonHighlightHiddenViewModel: ObservableObject {
    let name: String
    @Published var isHighlighted: Bool {
        didSet {
            onHighlighted(isHighlighted)
        }
    }
    @Published var isHidden: Bool
    
    var onHighlighted: (_ isHiglighted: Bool) -> Void
    
    init(
        name: String,
        isHighlighted: Bool,
        isHidden: Bool,
        onHighlighted: @escaping (_ isHighlighted: Bool) -> Void
    ) {
        self.name = name
        self.isHighlighted = isHighlighted
        self.isHidden = isHidden
        self.onHighlighted = onHighlighted
    }
}
