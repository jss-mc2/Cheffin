//
//  StepByStepProgressView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

struct StepByStepProgressView<Page: View>: View {
    @ObservedObject var pager: PageViewModel<Page>
    
    init(pager: PageViewModel<Page>) {
        self.pager = pager
    }
    
    var body: some View {
        ZStack {
            ProgressView(
                value: Double(pager.currentPage + 1),
                total: Double(pager.pages.count)
            )
                .progressViewStyle(LinearProgressViewStyle())
                .tint(.accentColor)
                .scaleEffect(CGSize(width: 1.1, height: 7.0))
            Text("\(pager.currentPage + 1) of \(pager.pages.count)")
        }
    }
}
