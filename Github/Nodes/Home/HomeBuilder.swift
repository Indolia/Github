//
//  HomeBuilder.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol HomeBuilderProtocol: AnyObject {
    func build(dependencies: HomeViewDependenciesProtocol) -> RootRouterProtocol
}

class HomeBuilder: HomeBuilderProtocol {
    func build(dependencies: HomeViewDependenciesProtocol) -> RootRouterProtocol {
        let viewBuilder = HomeViewBuilder(dependencies: dependencies)
        let viewModel = HomeViewModel(viewBuilder: viewBuilder)
        let router = HomeRouter(with: viewModel)
        viewModel.router = router
        return router
    }

}
