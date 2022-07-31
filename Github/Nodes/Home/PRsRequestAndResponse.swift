//
//  PRsRequestAndResponse.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

struct FetchPRsRequest {
    let url: URL
    let paging: Paging
    let param: [ String : Any]?
    let method: HttpMethod
    init?(urlString: String, paging: Paging, param: [ String : Any]?, method: HttpMethod) {
        let fullURLStr = urlString + "?page=\(paging.currentPage)"
        guard let url = URL(string: fullURLStr) else {
            print("Invalide url")
            return nil
        }
        self.url = url
        self.paging = paging
        self.param = param
        self.method = method
    }
}

struct Paging: Decodable {
    let totalItems: Int?
    let currentPage: Int
    let totalPages: Int
    let perPageItems: Int
}

struct FetchPRsResponse {
    let pullRequests: [PullRequestModel]
    let paging: Paging
    
    init(for jsonData: Data) throws {
        let decoder = JSONDecoder()
        do {
            pullRequests = try decoder.decode([PullRequestModel].self, from: jsonData)
            paging = Paging(totalItems: 1, currentPage: 1, totalPages: 10, perPageItems: 1)
            
        } catch (let someError){
            print(someError.localizedDescription)
            throw someError
        }
    }    
}



