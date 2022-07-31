//
//  HomeViewController.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import UIKit

protocol HomeViewActionDelegate:AnyObject {
    func filterPullRequests(for searchText: String)
    func logoutUser()
    func fetchNextPage()
}

protocol HomeViewProtocol:AnyObject {
    static func get(from: AppConstants.Storyboard, with nav: NavigationViewControllerProtocol, delegate: HomeViewActionDelegate, userType: UserType) -> HomeViewProtocol
    func pushInNavStack()
    func reloadData(for pullRequests: [PullRequestModel])
    func alert(for message: String)
    func setAsRootView()
    func stopFooterAnimation()
}


class HomeViewController: UIViewController {
    private var nav: NavigationViewControllerProtocol?
    weak var delegate: HomeViewActionDelegate?
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var PRsTableView: UITableView!
    private var viewSetupDone: Bool = false
    private var PRs = [PullRequestModel]()
    private var userType: UserType!
    var isPaginationInProgress: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        nav?.setNavigationBar(hidden: false, animation: true)
        tableViewSetup()
        viewSetupDone = true
        // Do any additional setup after loading the view.
    }
    
    
    private func uiSet() {
        title = "Home"
        if userType == UserType.member {
            setRightBarButtons(with: [])
        }
        
    }
    
    private func tableViewSetup() {
        PRsTableView.registerNib(String(describing: PullRequestDetailsTableViewCell.self))
        PRsTableView.estimatedRowHeight = 100
        PRsTableView.rowHeight = UITableView.automaticDimension
        PRsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    func setRightBarButtons(with image: [UIImage]) {
        let image = UIImage(named: "logout.png")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonTapped(button: )))
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc private func rightBarButtonTapped(button: UIBarButtonItem) {
        delegate?.logoutUser()
    }
}

extension HomeViewController: HomeViewProtocol {
    func stopFooterAnimation() {
        PRsTableView.tableFooterView = nil
        isPaginationInProgress = false
    }
    
    func reloadData(for pullRequests: [PullRequestModel]) {
        self.PRs = pullRequests
        if viewSetupDone {
            DispatchQueue.main.async {
                self.PRsTableView.reloadData()
            }
        }else {
            print("View setup no done")
        }
        
    }
    
    func alert(for message: String) {
        DispatchQueue.main.async {
            self.stopFooterAnimation()
            self.alert(title: "Info", message: message)
        }
    }
    
    func pushInNavStack(){
        nav?.push(viewController: self, animated: true)
    }
    
    func setAsRootView(){
        nav?.set(rootViewController: self)
    }
    
    static func get(from storyboard: AppConstants.Storyboard, with nav: NavigationViewControllerProtocol, delegate: HomeViewActionDelegate, userType: UserType) -> HomeViewProtocol {
        
        let vc = HomeViewController.get(with: "HomeViewController", storyboard: storyboard.rawValue) as? HomeViewController
        vc?.nav = nav
        vc?.delegate = delegate
        vc?.userType = userType
        guard let unwrappedVC = vc else {
            fatalError("HomeViewController not found in \(storyboard)")
        }
        
        return unwrappedVC
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  PRs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PullRequestDetailsTableViewCell.self), for: indexPath) as! PullRequestDetailsTableViewCell
        cell.setDetails(for: PRs[indexPath.row])
        return cell
    }
   
}

extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        delegate?.filterPullRequests(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        delegate?.filterPullRequests(for: "")
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let PRsCount = PRs.count
        
        guard PRsCount != 0, PRsCount - 1 == row else {
            return
        }
        
        fetchNextPage()
    }
    
    private  func fetchNextPage() {
        guard !isPaginationInProgress else {
            stopFooterAnimation()
            return
        }
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: PRsTableView.bounds.width, height: 36)
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.color = UIColor.skyBlue
        activityIndicator.center = CGPoint(x: PRsTableView.bounds.width/2, y: 18)
        view.addSubview(activityIndicator)
        PRsTableView.tableFooterView = view
        isPaginationInProgress = true
        delegate?.fetchNextPage()
        
    }
}


