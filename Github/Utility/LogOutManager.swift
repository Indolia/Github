//
//  LogOutManager.swift
//  Github
//
//  Created by Rishi Indolia on 31/07/22.
//

import Foundation

struct LogoutManager {
    static func logout() {
        IKeyChain.shared.delete(key: AppConstants.UserInfo.key)
    }
}
