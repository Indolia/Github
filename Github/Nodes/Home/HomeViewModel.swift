//
//  HomeViewModel.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var viewBuilder: HomeViewBuilderProtocol { get }
    var router: HomeRouterProtocol! { get }
}

class HomeViewModel: HomeViewModelProtocol {
    let viewBuilder: HomeViewBuilderProtocol
  weak  var router: HomeRouterProtocol!
  weak  private var view: HomeViewProtocol?
    lazy var interactor: HomeInteractor = HomeInteractor()
    private var currentPaging: Paging?
    private var pullRequests = [PullRequestModel]()
    private var PRsResponse: FetchPRsResponse? {
        willSet {
            if let someValue = newValue {
                currentPaging = someValue.paging
                if someValue.paging.currentPage == 1 {
                    pullRequests = someValue.pullRequests
                }else {
                    pullRequests.append(contentsOf: someValue.pullRequests)
                }
                self.view?.reloadData(for: self.pullRequests)
            }
        }
    }
    init(viewBuilder: HomeViewBuilderProtocol) {
        self.viewBuilder = viewBuilder
    }
}


extension HomeViewModel: RootViewModelProtocol {
    func didPush(completion: (() -> Void)?) {
        self.view = viewBuilder.build(with: self)
        self.view?.pushInNavStack()
        let paging = Paging(totalItems: nil, currentPage: 1, totalPages: 0, perPageItems: 0)
        self.getPullRequest(for: paging)
    }
    
    func didSetAsRoot(completion: (() -> Void)?) {
        self.view = viewBuilder.build(with: self)
        view?.setAsRootView()
        let paging = Paging(totalItems: nil, currentPage: 1, totalPages: 0, perPageItems: 0)
        self.getPullRequest(for: paging)
    }
}

extension HomeViewModel: HomeViewActionDelegate {
    func fetchNextPage() {
        if let paging = self.currentPaging, paging.currentPage < paging.totalPages {
            let nextPaging = Paging(totalItems: paging.totalItems, currentPage: paging.currentPage + 1, totalPages: paging.totalPages, perPageItems: paging.perPageItems)
            getPullRequest(for: nextPaging)
        }else {
            self.view?.stopFooterAnimation()
        }
    }
    
    func logoutUser() {
        LogoutManager.logout()
        setWelcomeAsLanding()
    }
    
    private func setWelcomeAsLanding() {
        let dependencies = WelcomeViewDependencies(nav: viewBuilder.dependencies.nav, storyboard: AppConstants.Storyboard.main)
        let router  = WelcomeBuilder().build(dependencies: dependencies)
        router.setAsRootView(completion: nil)
    }
    
    
    func filterPullRequests(for searchText: String) {
        if searchText.isEmpty {
            self.view?.reloadData(for: self.pullRequests)
        }else {
            
            let filterpullRequests = self.pullRequests.filter { (pr) -> Bool in
                return pr.searchable.lowercased().contains(searchText.lowercased())
            }
            self.view?.reloadData(for: filterpullRequests)
        }
    }
    
}


extension HomeViewModel {
    
    private func getPullRequest(for paging: Paging) {
        currentPaging = paging
        var url = AppConstants.ServerURL.baseURL(for: .alamofire, for: .all)
        if viewBuilder.dependencies.userType == .guest {
             url = AppConstants.ServerURL.baseURL(for: .own, for: .all)
        }
        
        let pr = FetchPRsRequest(urlString: url, paging: paging, param: nil, method: .GET)
        if let request = pr {
            getPullRequests(for: request)
        }
        
    }
    private func getPullRequests(for request: FetchPRsRequest) {
        interactor.fetchPullRequests(for: request) { [weak self](result) in
            switch result {
            case .failure(let error):
                self?.view?.alert(for: error.description)
            case .success(let prsResponse):
                self?.PRsResponse = prsResponse
            }
        }
    }
}

