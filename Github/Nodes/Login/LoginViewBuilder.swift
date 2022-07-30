//
//  LoginViewBuilder.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation
protocol LoginViewDependenciesProtocol {
    var storyboard: AppConstants.Storyboard { get }
    var nav: NavigationViewControllerProtocol {get}
    
}

struct LoginViewDependencies: LoginViewDependenciesProtocol{
    let nav: NavigationViewControllerProtocol
    let storyboard: AppConstants.Storyboard

}

protocol LoginViewBuilderProtocol: AnyObject {
   var dependencies: LoginViewDependenciesProtocol {get}
   func build(with delegate: LoginViewActionDelegate) -> LoginViewProtocol
}

class LoginViewBuilder: LoginViewBuilderProtocol {
    let dependencies: LoginViewDependenciesProtocol
    
    init(dependencies: LoginViewDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func build(with delegate: LoginViewActionDelegate) -> LoginViewProtocol {
        return LoginViewController.get(from: dependencies.storyboard, with: dependencies.nav, delegate: delegate)
    }
}

