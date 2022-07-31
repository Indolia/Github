//
//  HomeInteractor.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//


import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func fetchPullRequests(for prRequest: FetchPRsRequest, completion: @escaping(Result<FetchPRsResponse, NSError>) -> Void)
}

class HomeInteractor: RootInteractor, HomeInteractorProtocol {
    func fetchPullRequests(for prRequest: FetchPRsRequest, completion: @escaping (Result<FetchPRsResponse, NSError>) -> Void) {
        super.request(with: prRequest.param, for: prRequest.url, method: prRequest.method) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                self.decoderReponse(jsonData: data) { (decodedRuslt) in
                    switch decodedRuslt {
                    case .success(let PRsResponse):
                    completion(.success(PRsResponse))
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
           
        }
    }
    
    private func decoderReponse(jsonData: Data, completion: @escaping (Result<FetchPRsResponse, NSError>) -> Void) {
        
        do {
            let fetchPRsResponse = try FetchPRsResponse.init(for: jsonData)
            completion(.success(fetchPRsResponse))
        } catch {
            print(error)
            completion(.failure(error as NSError))
        }
        
    }
}



