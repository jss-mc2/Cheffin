//
//  RecipeViewController.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 30/06/23.
//

import UIKit

class RecipeViewController: UIViewController {

	
	let recipe: Recipe
	let viewModel: RecipeDetailViewModel
	
	init(recipe: Recipe, viewModel: RecipeDetailViewModel) {
		self.viewModel = viewModel
		self.recipe = recipe
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not Implemented")
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		self.viewModel.generateStepByStep(recipe: recipe)
		let hostingController = SwiftUIKitViewController(
			shouldShowNavigationBar: false,
			rootView: RecipePageView(recipe: recipe, viewModel: self.viewModel)
		)
		
		addChild(hostingController)
		
		view.addSubview(hostingController.view)
		
		hostingController.view.translatesAutoresizingMaskIntoConstraints = false
		hostingController.view.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalTo(view)
		}
		hostingController.didMove(toParent: self)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
