//
//  HomeRouter.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation
protocol HomeRouterProtocol: AnyObject {
    
}

class HomeRouter: RootRouter, HomeRouterProtocol {
    required init(with viewModel: RootViewModelProtocol) {
        super.init(with: viewModel)
    }
}

