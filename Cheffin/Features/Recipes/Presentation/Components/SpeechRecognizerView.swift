//
//  SpeechRecognizerView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 26/06/23.
//

import SwiftUI

struct SpeechRecognizerView: View {
    var buttonViews: [ButtonHighlightHiddenView]
    
    init(_ buttonViews: [ButtonHighlightHiddenView]) {
        self.buttonViews = buttonViews
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mic.fill").foregroundColor(I.accentColor.swiftUIColor)
                Text("try saying:")
                    .italic()
            }
            .font(.system(.title))
            WrappingHStack(alignment: .center) {
                ForEach(buttonViews.indices, id: \.self) {
                    buttonViews[$0]
                }
            }
            .font(.system(.title))
        }
    }
}

#if DEBUG
struct SpeechRecognizerViewPreviews: View {
    @State var buttonStates = [
        ButtonHighlightHiddenViewModel(name: "next", isHidden: false) {
            print("next isHighlighted")
        },
        ButtonHighlightHiddenViewModel(name: "back", isHidden: false) {
            print("back isHighlighted")
        },
        ButtonHighlightHiddenViewModel(name: "repeat", isHidden: false) {
            print("repeat isHighlighted")
        },
        ButtonHighlightHiddenViewModel(key: "set timer", name: "set timer 1 minutes", isHidden: false) {
            print("set timer 1 minutes")
        },
        ButtonHighlightHiddenViewModel(name: "start timer", isHidden: false) {
            print("start timer")
        },
        ButtonHighlightHiddenViewModel(name: "stop timer", isHidden: false) {
            print("stop timer")
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
                buttonStates.map { state in
                    ButtonHighlightHiddenView(state: state)
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
