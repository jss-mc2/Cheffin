//
//  StepsView.swift
//  Cheffin
//
//  Created by Hanif on 30/06/23.
//

import SwiftUI

struct StepsView: View {
    
    
    let steps = Array(1...12).map { "\($0) step number \($0)" }
    
    var body: some View {
        HStack {
            List {
                ForEach(steps, id: \.self) { item in
                    Text(item)
                }
            }
            Spacer()
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView()
    }
}
