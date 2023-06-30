//
//  FailureHandler.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 27/06/23.
//

import Foundation

func failureMessage(failure: Failure) -> String {

	switch failure {
	case .recipeFailure:
		return S.recipeFailure
	}
}
