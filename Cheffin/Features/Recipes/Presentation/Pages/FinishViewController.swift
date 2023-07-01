//
//  FinishViewController.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 01/07/23.
//

import UIKit

class FinishViewController: UIViewController {

	let name: String
	init(name: String) {
		self.name = name
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("Not implemented")
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let hostingController = SwiftUIKitViewController(
			shouldShowNavigationBar: false,
			rootView: FinishPage(name: self.name, controller: self)
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
    
	
	func navigateToHome() {
		
		let viewModel = InjectionContainer.shared.container.resolve(RecipeViewModel.self)!
		let home = HomeViewController(viewModel: viewModel)
		
		navigationController?.setViewControllers([home], animated: true)
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
