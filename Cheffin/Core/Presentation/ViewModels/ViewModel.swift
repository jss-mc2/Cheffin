//
//  ViewModel.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 27/06/23.
//

import Foundation

class ViewModel<S: ViewModelState>: ObservableObject {
	
	@Published private(set) var state: S = .initial()

	
	private var emitted = false
	private var privateState: S = .initial()
	
	func emit(state: S?) {
		
		if state == nil {
			return
		}
		if privateState == state && emitted {
			return
		}
		
		privateState = state!
		self.state = privateState
		emitted = true
		
	}
}
