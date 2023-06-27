//
//  State.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 27/06/23.
//

import Foundation

protocol State: Equatable {
	
	static func initial() -> Self
}
