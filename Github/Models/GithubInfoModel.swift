//
//  UserInfoModel.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

struct GithubInfoModel {
    let repoOwner: String
    let repoName: String
    let authToken: String
}

//MARK: - sign in logic
extension GithubInfoModel {
    func signIn(completion:(Any?)->Void) {
        let userData =  IKeyChain.shared.load(key: AppConstants.UserInfo.key)
        if let someUserData = userData {
            let userInfo = someUserData.unarchivedObject()
            completion(userInfo)
        }else {
            completion(nil)
        }
    }
}

//MARK: - sign up logic

extension GithubInfoModel {
    func signUp(completion:(Bool)->Void) {
        let userInfo = self.json()
        print(userInfo)
        let userData = Data.archivedData(from: userInfo)
        if let someData = userData {
            let status = IKeyChain.shared.save(key: AppConstants.UserInfo.key, data: someData)
            if status == noErr {
               completion(true)
            }else {
                completion(false)
            }
        }
    }
    
    func json()-> Dictionary<String,String> {
        let json = ["repoOwner" : self.repoOwner, "remoName" : self.repoName, "authToken" : self.authToken]
        return json
    }
}

