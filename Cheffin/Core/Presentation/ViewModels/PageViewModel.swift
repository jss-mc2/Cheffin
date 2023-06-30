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
        
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
    }
    
    func endOfPage() -> Bool {
        return currentPage + 1 == pages.count
    }
    
    func beginningOfPage() -> Bool {
        return currentPage == 0
    }
    
    /**
     - Returns: false if end of page
     */
    func nextPage() -> Bool {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
        if endOfPage() {
            return false
        }
        
        currentPage += 1
        return true
    }
    
    /**
     - Returns: false if beginning of page
     */
    func previousPage() -> Bool {
#if DEBUG
        print("\(type(of: self)) \(#function)")
#endif
        if beginningOfPage() {
            return false
        }
        
        currentPage -= 1
        return true
    }
}
