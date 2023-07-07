//
//  RecipeDetailViewModel.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 30/06/23.
//

import Foundation
import Combine

class RecipeDetailViewModel: ViewModel<RecipeDetailState> {
	
	private var cancellables = Set<AnyCancellable>()
	
	private let stepByStepMode: AnyUseCase<[StepByStep], ViewStepByStepModeParams>
	
	init(stepByStepMode: AnyUseCase<[StepByStep], ViewStepByStepModeParams>) {
		self.stepByStepMode = stepByStepMode
	}
	
	func generateStepByStep(recipe: Recipe) {
		
		stepByStepMode.execute(params: ViewStepByStepModeParams(recipe: recipe)) { output in
			output.receive(on: DispatchQueue.main)
				.sink { [weak self] completion in
					switch completion {
					case .finished: return
					case .failure(let failure):
						self?.emit(state: self?.state.with(status: .failure(failure: failure)))
						self?.emit(state: self?.state.with(status: .initial))

						return
					}
				} receiveValue: { [weak self] steps in
					self?.emit(state: self?.state.with(status: .success, stepBySteps: steps))
					self?.emit(state: self?.state.with(status: .initial))

				}
				.store(in: &self.cancellables)

		}
	}
}

struct RecipeDetailState: ViewModelState {
	static func initial() -> RecipeDetailState {
		RecipeDetailState(stepBySteps: [], status: .initial)
	}
	
	let stepBySteps: [StepByStep]
	let status: RecipeDetailStatus
	
	func with(
		status: RecipeDetailStatus?? = nil,
		stepBySteps: [StepByStep]?? = nil
	) -> Self {
		.init(
			stepBySteps: (stepBySteps ?? self.stepBySteps) ?? self.stepBySteps,
			status: (status ?? self.status) ?? self.status
		)
		
	}
}

enum RecipeDetailStatus: Equatable {
	case initial
	case success
	case failure(failure: Failure)
}
