//
//  LoginViewModel.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

enum LoginError: Error {
    case repoOwnerNameShouldNotBeEmpty
    case repoNameShouldNotBeEmpty
    case authTokenShouldNotBeEmpty
}

protocol LoginViewModelProtocol: AnyObject {
    var viewBuilder: LoginViewBuilderProtocol { get }
    var router: LoginRouterProtocol! { get }
}

class LoginViewModel: LoginViewModelProtocol {
    let viewBuilder: LoginViewBuilderProtocol
    weak var router: LoginRouterProtocol!
    private weak var view: LoginViewProtocol?
    private var homeRouter: RootRouterProtocol?
    private var userInfo: GithubInfoModel? {
        willSet{
            newValue?.signUp(completion: { (status) in
                print(status)
            })
        }
    }
    
    init(viewBuilder: LoginViewBuilderProtocol) {
        self.viewBuilder = viewBuilder
    }
}


extension LoginViewModel: RootViewModelProtocol {
    func didPush(completion: (() -> Void)?) {
        self.view = viewBuilder.build(with: self)
        self.view?.pushInNavStack()
    }
}

extension LoginViewModel: LoginViewActionDelegate {
    func successfullLogedIn() {
       
    }
    
    func validateDetails(with repoOwner: String?, repoName: String?, authToken: String?, completion: (Result<Bool, LoginError>) -> Void) {
        do {
            try validate(repoOwner: repoOwner, and: repoName, authToken: authToken) { (valid, userInfo) in
                self.userInfo = userInfo
                completion(.success(true))
            }
        } catch (let error) {
            completion(.failure(error as! LoginError))
        }
    }
    
}

extension LoginViewModel {
    func validate(repoOwner: String?, and repoName: String?, authToken: String? , completion:(Bool, GithubInfoModel )->Void) throws {
       
        guard let someRepoOwner = repoOwner, !someRepoOwner.isEmpty else {
            throw LoginError.repoOwnerNameShouldNotBeEmpty
        }
        
        guard let someRepoName = repoName, !someRepoName.isEmpty else{
            throw LoginError.repoNameShouldNotBeEmpty
        }
        
        guard let someAuthToken = authToken, !someAuthToken.isEmpty else{
            throw LoginError.authTokenShouldNotBeEmpty
        }
       
        let model = GithubInfoModel(repoOwner: someRepoOwner, repoName: someRepoName, authToken: someAuthToken)
        completion(true , model)
    }
 
}

extension LoginError: LocalizedError {
    var localizedDescription: String {
        get {
            switch self {
            case .repoOwnerNameShouldNotBeEmpty:
                return "Please enter a valid owner name."
            case.repoNameShouldNotBeEmpty:
                return "Please enter a valid repo name."
            case .authTokenShouldNotBeEmpty:
                return "Please enter a valid auth token."
            }
        }
    }
}


