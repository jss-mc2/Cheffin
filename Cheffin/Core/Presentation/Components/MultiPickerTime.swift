//
//  MultiPickerTime.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI

/**
 TODO: not MVP
 1. Cancel button
 2. Start button
 3. selection listener to convert selection as TimeInterval
 */
struct MultiPickerTime: View {
    
    typealias Label = String
    typealias Entry = String
    
    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]
    
    var body: some View {
        HStack {
            ForEach(data.indices, id: \.self) { column in
                Picker("hours", selection: $selection[column]) {
                    ForEach(data[column].1.indices, id: \.self) { row in
                        Text(verbatim: data[column].1[row])
                            .tag(data[column].1[row])
                    }
                }
                .pickerStyle(.wheel)
                
                Text(data[column].0)
            }
        }.padding()
    }
}

#if DEBUG
struct MultiPickerTimePreviews: View {
    @State var data: [(String, [String])] = [
        ("hours", Array(0...23).map { "\($0)" }),
        ("min", Array(0...59).map { "\($0)" }),
        ("sec", Array(0...59).map { "\($0)" })
    ]
    @State var selection: [String] = [0, 20, 100].map { "\($0)" }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(verbatim: "Selection: \(selection)")
            MultiPickerTime(data: data, selection: $selection).frame(height: 300)
        }
    }
}

struct MultiPickerTime_Previews: PreviewProvider {
    static var previews: some View {
        MultiPickerTimePreviews()
    }
}
#endif
