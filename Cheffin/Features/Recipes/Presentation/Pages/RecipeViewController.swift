//
//  RecipeViewController.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 30/06/23.
//

import UIKit

class RecipeViewController: UIViewController {

	
	let recipe: Recipe
	
	init(recipe: Recipe) {
		self.recipe = recipe
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not Implemented")
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .red

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
