//
//  LoginViewController.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import UIKit

protocol LoginViewActionDelegate:AnyObject {
    func validateDetails(with repoOwner: String?, repoName: String?, authToken: String?, completion:(Result<Bool, LoginError>)->Void)
    func successfullLogedIn()
}

protocol LoginViewProtocol:AnyObject {
    static func get(from: AppConstants.Storyboard, with nav: NavigationViewControllerProtocol, delegate: LoginViewActionDelegate) -> LoginViewProtocol
    func pushInNavStack()
}

class LoginViewController: UIViewController {
    @IBOutlet var repoOwnerNameTextField: UITextField!
    @IBOutlet var repoNameTextField: UITextField!
    @IBOutlet var authTokenTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    private var nav: NavigationViewControllerProtocol?
    weak var delegate: LoginViewActionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav?.setNavigationBar(hidden: false, animation: true)
        self.title = "Login"
        uiSetup()
        // Do any additional setup after loading the view.
    }
    
    private func uiSetup() {
        loginButton.applyGradient(colours: UIColor.gradientColors, locations: [0.5 , 1.0])
        loginButton.cornerRadius(with: 8)
    }
    
    @IBAction func login(_ sender: Any) {
        delegate?.validateDetails(with: repoOwnerNameTextField.text, repoName: repoNameTextField.text, authToken: authTokenTextField.text, completion: { (result) in
            switch result {
            case .success( _):
                delegate?.successfullLogedIn()
            case .failure(let error):
                alert(title: "Info", message: error.localizedDescription)
            }
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func pushInNavStack(){
        nav?.push(viewController: self, animated: true)
    }
    
    static func get(from storyboard: AppConstants.Storyboard, with nav: NavigationViewControllerProtocol, delegate: LoginViewActionDelegate) -> LoginViewProtocol {
        
        let vc = LoginViewController.get(with: AppConstants.ViewControllerStotyboardId.loginViewController, storyboard: storyboard.rawValue) as? LoginViewController
        vc?.nav = nav
        vc?.delegate = delegate
        guard let unwrappedVC = vc else {
            fatalError("LoginViewController not found in \(storyboard)")
        }
        
        return unwrappedVC
    }
}

