//
//  SpeechRecognizerButtonView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/06/23.
//

import SwiftUI

struct ButtonHighlightHiddenView: View {
    @ObservedObject var state: ButtonHighlightHiddenViewModel
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    var body: some View {
        let foregroundColor = (colorScheme == .dark && state.isHighlighted) ? .black : I.textPrimary.swiftUIColor
        let cornerRadius = CGFloat(10)
        
        Group {
            if state.isHidden {
                EmptyView()
            } else {
                Button(
                    action: {
                        state.isHighlighted.toggle()
                    },
                    label: {
                        Text(state.name)
                            .foregroundColor(foregroundColor)
                            .padding(.all, 8)
                        
                            .background(state.isHighlighted ? I.primary.swiftUIColor : .clear)
                            // to force background to respect cornerRadius.
                            .cornerRadius(cornerRadius)
                            // to show border line when isHighlighted == false
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(I.primary.swiftUIColor, lineWidth: 2)
                            )
                    }
                )
            }
        }
    }
}

#if DEBUG
struct SpeechRecognizerButtonViewPreviews: View {
    @State var buttonState = ButtonHighlightHiddenViewModel(
        name: S.voiceCommand("next"),
        isHighlighted: false,
        isHidden: false
    ) { isHiglighted in
        print("next isHiglighted \(isHiglighted)")
    }
    
    
    var body: some View {
        VStack {
            Button(
                action: {
                    buttonState.isHidden.toggle()
                },
                label: {
                    Text("Toggle \(buttonState.name) isHidden variable")
                }
            )
            ButtonHighlightHiddenView(state: buttonState)
        }
    }
}

struct SpeechRecognizerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognizerButtonViewPreviews()
    }
}
#endif
