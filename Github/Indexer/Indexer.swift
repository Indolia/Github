//
//  Indexer.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation
import UIKit

struct Indexer {
    var rootRouter: RootRouterProtocol?
    enum RootViewType {
        case welcome
        case home
    }
    
    mutating func setLandingIndex() {
        let landingView = getLandingViewType()
        switch landingView {
        case .welcome:
            setWelcomeAsLanding()
        case .home:
            setHomeAsLandig()
        }
    }
    
    func getLandingViewType()-> RootViewType {
        if IKeyChain.shared.isLogedIn {
            return .home
        }
        return .welcome
    }
    
    
    private mutating func setWelcomeAsLanding() {
        let dependencies = WelcomeViewDependencies(nav: NavigationViewController.current, storyboard: AppConstants.Storyboard.main)
        rootRouter  = WelcomeBuilder().build(dependencies: dependencies)
        rootRouter?.setAsRootView(completion: nil)
    }
    
    private mutating func setHomeAsLandig() {
        let dependencies = HomeViewDependencies(userType: .member, nav: NavigationViewController.current, storyboard: AppConstants.Storyboard.main)
        rootRouter = HomeBuilder().build(dependencies: dependencies)
        rootRouter?.setAsRootView(completion: nil)
    }
    
}
