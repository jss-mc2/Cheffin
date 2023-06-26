//
//  UseCase.swift
//  Cheffin
//
//  Created by Adryan Eka Vandra on 19/06/23.
//

import Foundation
import Combine


protocol UseCaseProtocol {
    associatedtype ReturnType
    associatedtype Params: Equatable

    func execute(params: Params, completion: @escaping (AnyPublisher<ReturnType, Failure>) -> Void )
}

struct AnyUseCase<T, P: Equatable>: UseCaseProtocol {
    func execute(params: P, completion: @escaping (AnyPublisher<T, Failure>) -> Void) {
        self.proceed(params, completion)
    }


    init<U>(useCase: U) where U: UseCaseProtocol, U.ReturnType == T, U.Params == P {
        self.proceed = useCase.execute
    }


    private let proceed: (P, @escaping (AnyPublisher<ReturnType, Failure>) -> Void) -> Void

    typealias ReturnType = T
    typealias Params = P


}

extension UseCaseProtocol {
    func eraseToAnyUseCase() -> AnyUseCase<ReturnType, Params> {
        return AnyUseCase<ReturnType, Params>(useCase: self)
    }
}
struct NoParams: Equatable {}
