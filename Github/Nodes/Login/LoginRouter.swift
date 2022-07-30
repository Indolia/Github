//
//  LoginRouter.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol LoginRouterProtocol: AnyObject { }

class LoginRouter: RootRouter, LoginRouterProtocol {
   
    required init(with viewModel: RootViewModelProtocol) {
        super.init(with: viewModel)
    }
}

