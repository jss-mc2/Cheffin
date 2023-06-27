//
//  RecipeViewModel.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import Foundation
import Combine

class RecipeViewModel: ViewModel<RecipeState> {
	
	private let useCase: AnyUseCase<[Recipe], NoParams>
	private var cancellables = Set<AnyCancellable>()
	
	init(useCase: AnyUseCase<[Recipe], NoParams>) {
		self.useCase = useCase
	}
	
	func getRecipes() {
		emit(state: self.state.with(status: .loading))
		useCase.execute(params: NoParams()) { output in
			output
				.receive(on: DispatchQueue.main)
				.sink { [weak self] completion in
				switch completion {
				case .finished: return
				case .failure(let failure):
					self?.emit(state: self?.state.with(status: .failure(failure: failure)))
					return
				}
			} receiveValue: {[weak self] recipes in
				self?.emit(state: self?.state.with(
					status: .success,
					recipes: recipes
				))
				
				self?.emit(state: self?.state.with(status: .initial))
				}
			.store(in: &self.cancellables)

			
		}
	}
	
}

struct RecipeState: State {
	
	let status: RecipeStatus
	let recipes: [Recipe]
	
	
	static func initial() -> RecipeState {
		.init(status: .initial, recipes: [])
	}
	
	func with(
		status: RecipeStatus?? = nil,
		recipes: [Recipe]?? = nil
	) -> Self {
		.init(
			status: (status ?? self.status) ?? self.status,
			recipes: (recipes ?? self.recipes) ?? self.recipes
		)
		
	}
	
	enum RecipeStatus: Equatable {
		case initial
		case success
		case failure(failure: Failure)
		case loading
	}
	
}
