//
//  InjectionContainer.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 19/06/23.
//

import Foundation
import CoreData
import Swinject
import SwinjectAutoregistration

final class InjectionContainer {

    static let shared = InjectionContainer()
    private var _container: Container?

    var container: Container {
        get {
            guard let contain = _container else {
                let newContainer = buildContainer()
                _container = newContainer
                return newContainer
            }
            return contain
        }
        set {
            _container = newValue
        }
    }

    private func buildContainer() -> Container {
        let container = Container()
        // register component here
        self.registerSharedContainer(container)
		self.registerRecipeContainer(container)

        return container
    }

    private func registerSharedContainer(_ container: Container) {

        // MARK: UserDefaults
        container.register(UserDefaults.self) { _ in
            return UserDefaults.standard

        }
        .inObjectScope(.container)
    }
	
	private func registerRecipeContainer(_ container: Container) {
		
	}

}
