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


    override func viewDidLoad() {
        super.viewDidLoad()

        let hostingController = UIHostingController(rootView: HomePage())
        addChild(hostingController)

        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
        hostingController.didMove(toParent: self)

    }


}
