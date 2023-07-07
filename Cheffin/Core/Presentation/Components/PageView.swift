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
        pageViewModel.pages[pageViewModel.currentPage]
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
