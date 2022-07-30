//
//  WelcomeViewBuilder.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol WelcomeViewDependenciesProtocol {
    var storyboard: AppConstants.Storyboard { get }
    var nav: NavigationViewControllerProtocol {get}
    
}

struct WelcomeViewDependencies: WelcomeViewDependenciesProtocol{
    let nav: NavigationViewControllerProtocol
    let storyboard: AppConstants.Storyboard

}

protocol WelcomeViewBuilderProtocol: AnyObject {
   var dependencies: WelcomeViewDependenciesProtocol {get}
   func build(with delegate: WelcomeViewActionDelegate) -> WelcomeViewProtocol
}

class WelcomeViewBuilder: WelcomeViewBuilderProtocol {
    
    let dependencies: WelcomeViewDependenciesProtocol

    init(dependencies: WelcomeViewDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func build(with delegate: WelcomeViewActionDelegate) -> WelcomeViewProtocol {
        return WelcomeViewController.get(from: dependencies.storyboard, with: dependencies.nav, delegate: delegate)
    }
    
}

