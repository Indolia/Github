//
//  AppConstants.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

struct AppConstants {
    struct UserInfo {
        static let key:String = "github_user_account_info_key"
    }
    
    enum Storyboard: String {
        case main = "Main"
    }
   
    struct ViewControllerStotyboardId {
        static let navigationViewController = "NavigationViewController"
        static let welcomeViewController = "WelcomeViewController"
        static let loginViewController  = "LoginViewController"
        static let homeViewController = "HomeViewController"
    }
    
    struct ServerURL {
        enum RepoName: String {
            case owm = "Indolia/Github"
            case alamofire = "Alamofire/Alamofire"
        }
        
        enum PRsState:String {
            case open, closed, all
        }
        
        static func baseURL(for repo: RepoName, for state:PRsState) -> String {
            let baseURL = "https://api.github.com/repos/" + repo.rawValue + "/pulls?state=all"  //+ state.rawValue
            return baseURL
        }

    }
}
