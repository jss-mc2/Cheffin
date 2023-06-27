//
//  SpeechRecognizerView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/06/23.
//

import SwiftUI

struct SpeechRecognizerView: View {
    var buttons: [ButtonHighlightHiddenView]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mic.fill").foregroundColor(I.accentColor.swiftUIColor)
                Text("try saying:").italic()
            }
            WrappingHStack(alignment: .leading) {
                ForEach(buttons.indices, id: \.self) {
                    buttons[$0]
                }
            }
        }
    }
}

#if DEBUG
struct SpeechRecognizerViewPreviews: View {
    @State var buttonStates = [
        ButtonHighlightHiddenViewModel(
            name: S.voiceCommand("next"),
            isHighlighted: false,
            isHidden: false
        ) { isHighlighted in
            print("next isHighlighted \(isHighlighted)")
        },
        ButtonHighlightHiddenViewModel(
            name: S.voiceCommand("back"),
            isHighlighted: false,
            isHidden: false
        ) { isHighlighted in
            print("back isHighlighted \(isHighlighted)")
        },
        ButtonHighlightHiddenViewModel(
            name: S.voiceCommand("repeat"),
            isHighlighted: false,
            isHidden: false
        ) { isHighlighted in
            print("repeat isHighlighted \(isHighlighted)")
        },
        ButtonHighlightHiddenViewModel(
            name: S.voiceCommand("set timer ... minutes"),
            isHighlighted: false,
            isHidden: false
        ) { isHighlighted in
            print("set timer ... minutes isHighlighted \(isHighlighted)")
        },
        ButtonHighlightHiddenViewModel(
            name: S.voiceCommand("start timer"),
            isHighlighted: false,
            isHidden: false
        ) { isHighlighted in
            print("start timer isHighlighted \(isHighlighted)")
        },
        ButtonHighlightHiddenViewModel(
            name: S.voiceCommand("stop timer"),
            isHighlighted: false,
            isHidden: false
        ) { isHighlighted in
            print("stop timer isHighlighted \(isHighlighted)")
        }
    ]
    
    var body: some View {
        VStack {
            ForEach(buttonStates.indices, id: \.self) { index in
                Button(
                    action: {
                        buttonStates[index].isHidden.toggle()
                    },
                    label: {
                        Text("Toggle \(buttonStates[index].name) isHidden variable")
                    }
                )
            }
            SpeechRecognizerView(
                buttons: buttonStates.map { buttonState in
                    ButtonHighlightHiddenView(state: buttonState)
                }
            )
        }
    }
}

struct SpeechRecognizerView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognizerViewPreviews()
    }
}
#endif
