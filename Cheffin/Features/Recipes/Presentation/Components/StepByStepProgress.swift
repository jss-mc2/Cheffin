//
//  ProgressView.swift
//  Cheffin
//
//  Created by Martinus Andika Novanawa on 27/06/23.
//

import SwiftUI

struct ProgressBar: View {
    var body: some View {
        ProgressView("Processing")
            .progressViewStyle(LinearProgressViewStyle())
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
