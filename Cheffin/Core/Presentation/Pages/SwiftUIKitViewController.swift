//
//  SwiftUIKitViewController.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 23/06/23.
//

import SwiftUI
import UIKit

class SwiftUIKitViewController<Content>: UIHostingController<AnyView> where Content: View {
	
	public init(shouldShowNavigationBar: Bool, rootView: Content) {
		super.init(rootView: AnyView(rootView.navigationBarHidden(!shouldShowNavigationBar)))
	}
	
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// protocol SwiftUIKitViewController: UIViewController {

//	fileprivate var viewModel: VM


//	init(viewModel: VM, view: V) {
//		self.viewModel = viewModel
//		super.init(nibName: nil, bundle: nil)
//
//	}
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//
//		let hostingController = UIHostingController(rootView: View)
//	}
// }
