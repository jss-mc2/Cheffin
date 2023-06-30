//
//  ButtonHighlight.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

struct ButtonHighlight: View {
    @StateObject var viewModel: ButtonHighlightViewModel
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    init(viewModel: ButtonHighlightViewModel) {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        let foregroundColor = (colorScheme == .dark && viewModel.isHighlighted) ? .black : I.textPrimary.swiftUIColor
        let cornerRadius = CGFloat(10)
        
        return Button(
            action: {
                viewModel.isHighlighted = true
                viewModel.action()
            },
            label: {
                Text(S.voiceCommand(viewModel.label))
                    .font(.system(.title, weight: .regular))
                    .foregroundColor(foregroundColor)
                    .padding(.all, 8)
                    .italic()
                
                    .background(viewModel.isHighlighted ? I.primary.swiftUIColor : .clear)
                    // to force background to respect cornerRadius.
                    .cornerRadius(cornerRadius)
                    // to show border line when isHighlighted == false
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(I.primary.swiftUIColor, lineWidth: 2)
                    )
            }
        )
        .onAppear {
#if DEBUG
            print("\(type(of: self)) \(#function) appeared")
#endif
        }
        .onDisappear {
#if DEBUG
            print("\(type(of: self)) \(#function) disappeared")
#endif
        }
    }
}
