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

        // MARK: - UserDefaults
        container.register(UserDefaults.self) { _ in
            return UserDefaults.standard

        }
        .inObjectScope(.container)

        // MARK: - UrlSession
        container.register(URLSession.self) { _ in
            URLSession.shared
        }
        .inObjectScope(.container)
    }

    private func registerRecipeContainer(_ container: Container) {

//        container.autoregister(RecipeRemoteDataSource.self, initializer: RecipeFakeDataSource.init)
        container.autoregister(RecipeRemoteDataSource.self, initializer: RecipeRemoteDataSourceGithubImpl.init)
        container.autoregister(RecipeRepository.self, initializer: RecipeRepositoryImpl.init)
        
        container.register(AnyUseCase<[Recipe], NoParams>.self, name: "GetRecipe") { resolver in
            let repo = resolver.resolve(RecipeRepository.self)!
            let usecase = AnyUseCase(useCase: GetRecipeImpl(repository: repo))
            return usecase.eraseToAnyUseCase()
        }
        
        container.autoregister(StepByStepParser.self, initializer: StepByStepParserImpl.init)
        container.register(
            AnyUseCase<[StepByStep], ViewStepByStepModeParams>.self,
            name: "ViewStepByStepMode") { resolver in
            let parser = resolver.resolve(StepByStepParser.self)!
            let usecase = AnyUseCase<
                [StepByStep],
                ViewStepByStepModeParams>(useCase: ViewStepByStepModeImpl(parser: parser))
            return usecase.eraseToAnyUseCase()
        }
		container.register(RecipeViewModel.self) { resolver in
			let usecase = resolver.resolve(AnyUseCase<[Recipe], NoParams>.self, name: "GetRecipe")!
			return RecipeViewModel(useCase: usecase)
		}
    }

}
