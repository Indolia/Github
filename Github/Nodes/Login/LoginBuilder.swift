//
//  LoginBuilder.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol LoginBuilderProtocol: AnyObject {
    func build(dependencies: LoginViewDependenciesProtocol) -> RootRouterProtocol
}

class LoginBuilder: LoginBuilderProtocol {
    func build(dependencies: LoginViewDependenciesProtocol) -> RootRouterProtocol {
        let viewBuilder = LoginViewBuilder(dependencies: dependencies)
        let viewModel = LoginViewModel(viewBuilder: viewBuilder)
        let router = LoginRouter(with: viewModel)
        viewModel.router = router
        return router
    }

}
