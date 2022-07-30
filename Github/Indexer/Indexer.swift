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
    }
    
    mutating func setLandingIndex() {
        let landingView = getLandingViewType()
        switch landingView {
        case .welcome:
            setWelcomeAsLanding()
        }
    }
    
    func getLandingViewType()-> RootViewType {
        return .welcome
    }
    
    
    private mutating func setWelcomeAsLanding() {
        let dependencies = WelcomeViewDependencies(nav: NavigationViewController.current, storyboard: AppConstants.Storyboard.main)
        rootRouter  = WelcomeBuilder().build(dependencies: dependencies)
        rootRouter?.setAsRootView(completion: nil)
    }
    
}
