//
//  StepByStepTitleView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

struct StepByStepTitleView<Page: View>: View {
    @ObservedObject var pager: PageViewModel<Page>
    let steps: [StepByStep]
    
    init(pager: PageViewModel<Page>, steps: [StepByStep]) {
        self.pager = pager
        self.steps = steps
    }
    
    var body: some View {
        Text(steps[pager.currentPage].title)
            .font(.system(.title2, weight: .semibold))
            .padding(.top, 32)
    }
}
