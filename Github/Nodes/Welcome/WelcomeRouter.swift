//
//  WelcomeRouter.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation
protocol WelcomeRouterProtocol: AnyObject {
    
}

class WelcomeRouter: RootRouter, WelcomeRouterProtocol {
    
    required init(with viewModel: RootViewModelProtocol) {
        super.init(with: viewModel)
    }
}

