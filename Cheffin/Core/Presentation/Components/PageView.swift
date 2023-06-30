//
//  PageView.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 30/06/23.
//

import SwiftUI

struct PageView<Page: View>: View {
    @ObservedObject var pageViewModel: PageViewModel<Page>
    
    init(pager: PageViewModel<Page>) {
        self.pageViewModel = pager
        
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    var body: some View {
        HStack {
            if !pageViewModel.beginningOfPage() {
                Button(
                    action: { _ = pageViewModel.previousPage() },
                    label: { Text("<") }
                )
            }
            pageViewModel.pages[pageViewModel.currentPage]
            if !pageViewModel.endOfPage() {
                Button(
                    action: { _ = pageViewModel.nextPage() },
                    label: { Text(">") }
                )
            }
        }
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
