//
//  PageViewModel.swift
//  Cheffin
//
//  Created by Jason Rich Darmawan Onggo Putra on 27/06/23.
//

import SwiftUI

class PageViewModel<Page: View>: ObservableObject {
    @Published var currentPage = 0
    @Published var pages: [Page]
    
    init(_ pages: [Page]) {
        self.pages = pages
    }
    
    /**
     - Returns: false if end of page
     */
    func nextPage() -> Bool {
        if currentPage + 1 == pages.count {
#if DEBUG
            print("\(#function) end of page")
#endif
            return false
        } else {
            currentPage += 1
        }
        
        return true
    }
    
    /**
     - Returns: false if beginning of page
     */
    func previousPage() -> Bool {
        if currentPage == 0 {
#if DEBUG
            print("\(#function) beginning of page")
#endif
            return false
        } else {
            currentPage -= 1
        }
        
        return true
    }
}
