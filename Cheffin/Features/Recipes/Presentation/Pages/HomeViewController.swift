//
//  ViewController.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 16/06/23.
//

import UIKit
import SwiftUI
import SnapKit

class HomeViewController: UIViewController {

	let viewModel: RecipeViewModel
	
	init(viewModel: RecipeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		self.viewModel.getRecipes()
		let hostingController = SwiftUIKitViewController(
			shouldShowNavigationBar: false,
			rootView: HomePage(
				controller: self,
				viewModel: self.viewModel
			)
		)

        addChild(hostingController)

        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
        hostingController.didMove(toParent: self)

    }
	
	func navigateToRecipePage(recipe: Recipe) {
		let viewModel = InjectionContainer.shared.container.resolve(RecipeDetailViewModel.self)!
		let recipeVC = RecipeViewController(recipe: recipe, viewModel: viewModel)
		navigationController?.pushViewController(recipeVC, animated: true)
	}


}
