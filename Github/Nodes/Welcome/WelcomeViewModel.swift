//
//  WelcomeViewModel.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol WelcomeViewModelProtocol: AnyObject {
    var viewBuilder: WelcomeViewBuilderProtocol { get }
    var router: WelcomeRouterProtocol! { get }
}

class WelcomeViewModel: WelcomeViewModelProtocol {
    let viewBuilder: WelcomeViewBuilderProtocol
    weak var router: WelcomeRouterProtocol!
    weak private var view: WelcomeViewProtocol?
    var homeRouterProtocol: RootRouterProtocol?
    var loginRouter: RootRouterProtocol?
    
    init(viewBuilder: WelcomeViewBuilderProtocol) {
        self.viewBuilder = viewBuilder
    }
}


extension WelcomeViewModel: RootViewModelProtocol {
    func didSetAsRoot(completion: (() -> Void)?) {
        self.view = viewBuilder.build(with: self)
        view?.setAsRootView()
    }
}

extension WelcomeViewModel: WelcomeViewActionDelegate {
    func proceedAsA(_ userType: UserType) {
        switch userType {
        case .guest:
            home()
        case .member:
            login()
        }
    }
    
    private func login() {
       
    }
    
    private func home() {
       
    }
}