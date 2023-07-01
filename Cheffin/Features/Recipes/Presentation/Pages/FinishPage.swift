//
//  FinishPage.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 01/07/23.
//

import SwiftUI
import LottieUI
import PhotosUI
struct FinishPage: View {
	let name: String
	let confetti = LUStateData(type: .name("confetti", .main), loopMode: .loop)
	
	@State private var showCameraCaptureView = false
	@State private var imageWrapper: ImageWrapper?
	@State private var showShareSheet = false
	
	let controller: FinishViewController
	
    var body: some View {
		VStack {
			HStack {
				Spacer()
                Button {
                    controller.navigateToHome()
                } label: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                }.tint(I.closeButton.swiftUIColor)
			}
			.padding()
            
			Spacer()
			LottieView(state: confetti)
				.frame(width: UIScreen.main.bounds.width * (1 / 1.5), height: UIScreen.main.bounds.height * (1 / 3))
				.clipped()
			Spacer()
			Text(S.bonApetit)
				.font(.largeTitle)
				.padding()
			Text(S.congratulationMessage(name))
				.font(.subheadline)
				.multilineTextAlignment(.center)
			Spacer()
			
			Button {
				showCameraCaptureView.toggle()
			} label: {
				HStack {
					Image(systemName: "camera")
					Text(S.takeAPicture)
					
				}
				.frame(minWidth: 0,
					   maxWidth: .infinity
				
				)
				.foregroundColor(I.blackText.swiftUIColor)
				.padding()

				
			}
			.padding(.horizontal, 48)
			.tint(I.primary.swiftUIColor)
			.buttonStyle(.borderedProminent)
			Spacer()

		}
		.padding()
		
		.sheet(isPresented: $showCameraCaptureView) {
			CameraCaptureView(capturedImage: Binding<UIImage?>(
				get: {
					self.imageWrapper?.image
				},
				set: {
					guard let image = $0 else {
						return
					}
					self.imageWrapper = ImageWrapper(id: UUID(), image: image)

				}
				
			))
		}
		.sheet(item: $imageWrapper) { image in
			ActivityViewController(imageWrapper: image)
		}
    }
}

struct FinishPage_Previews: PreviewProvider {
    static var previews: some View {
		let name = "Garlic Butter Steak"
		let controller = FinishViewController(name: name)
        FinishPage(name: name, controller: controller)
    }
}
