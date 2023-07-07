//
//  ActivityViewController.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 01/07/23.
//

import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
	let imageWrapper: ImageWrapper
	func makeUIViewController(context: Context) -> UIActivityViewController {
		UIActivityViewController(activityItems: [imageWrapper.image], applicationActivities: nil)
	}
	
	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
	}
}

struct ImageWrapper: Identifiable {
	let id: UUID
	let image: UIImage
}
