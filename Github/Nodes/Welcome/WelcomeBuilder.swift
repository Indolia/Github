//
//  WelcomeBuilder.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol WelcomeBuilderProtocol: AnyObject {
    func build(dependencies: WelcomeViewDependenciesProtocol) -> RootRouterProtocol
}

class WelcomeBuilder: WelcomeBuilderProtocol {
    func build(dependencies: WelcomeViewDependenciesProtocol) -> RootRouterProtocol {
        let viewBuilder = WelcomeViewBuilder(dependencies: dependencies)
        let viewModel = WelcomeViewModel(viewBuilder: viewBuilder)
        let router = WelcomeRouter(with: viewModel)
        viewModel.router = router
        return router
    }

}
