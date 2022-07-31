//
//  UserInfo.swift
//  Github
//
//  Created by Rishi Indolia on 31/07/22.
//

import Foundation


protocol UserInfoModelProtocal: Decodable {
    var id: Int { get }
    var login: String {get}
    var nodeId: String { get }
    var avatarURL: String { get }
    var profileURL: String { get }
    var userType: String { get }
}

struct UserInfoModel: UserInfoModelProtocal {
    
    let id: Int
    let login: String
    let nodeId: String
    let avatarURL: String
    let profileURL: String
    let userType: String
    
   
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserInfoModelCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
        nodeId = try container.decode(String.self, forKey: .nodeId)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        profileURL = try container.decode(String.self, forKey: .profileURL)
        userType = try container.decode(String.self, forKey: .userType)
    }
}

enum UserInfoModelCodingKeys: String, CodingKey {
    case id = "id"
    case login = "login"
    case nodeId = "node_id"
    case avatarURL =  "avatar_url"
    case profileURL = "url"
    case userType = "type"
}

