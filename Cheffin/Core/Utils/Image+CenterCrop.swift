//
//  Image+CenterCrop.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 01/07/23.
//

import SwiftUI

extension Image {
	func centerCropped() -> some View {
		GeometryReader { geo in
			self
				.resizable()
				.scaledToFill()
				.clipped()
		}
	}
}
