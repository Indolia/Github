//
//  AppConstants.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

struct AppConstants {
    struct UserInfo {
        static let key:String = "top_headlines_user_info_key"
    }
    
    enum Storyboard: String {
        case main = "Main"
    }
   
    struct ViewControllerStotyboardId {
        static let navigationViewController = "NavigationViewController"
        static let welcomeViewController = "WelcomeViewController"
        static let signInOrSignUpViewController  = "SignInOrSignUpViewController"
        static let headlinesTableViewController = "HeadlinesTableViewController"
        static let headlineDetailsTableViewController = "HeadlineDetailsTableViewController"
    }
    
    struct ServerURL {
        static let baseURL = "https://api.github.com/repos/Indolia/Github/pulls?state=all"
    }
}
