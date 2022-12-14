//
//  RootInteractor.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation

enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

protocol RootInteractorProtocol: AnyObject {
    func request(with param: [String : Any]?,for url: URL, method type: HttpMethod, handler:@escaping(Result<Data,NSError>)->Void)
}

class RootInteractor: RootInteractorProtocol {
    func request(with param: [String : Any]?, for url: URL, method type: HttpMethod, handler: @escaping (Result<Data, NSError>) -> Void) {
        if let data = encodeRequestParam(param: param) {
            requestWithBody(data: data, for: url, method: type, handler: handler)
        }else {
            requestWithOutBody(for: url, method: type, handler: handler)
        }
    }
    
    private func requestWithOutBody(for url: URL, method type: HttpMethod, handler: @escaping (Result<Data, NSError>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        urlRequest.addValue("token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", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request(with: urlRequest) { (result) in
            handler(result)
        }
    }
    
    private func requestWithBody(data: Data, for url: URL, method type: HttpMethod, handler: @escaping (Result<Data, NSError>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        urlRequest.httpBody = data
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request(with: urlRequest) { (result) in
            handler(result)
        }
    }
    
    private func request(with request: URLRequest, handler: @escaping (Result<Data, NSError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil , let jsonData = data {
                
                do {
                    // make sure this JSON is in the format we expect
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                
                    if let array =  json as? [[String: Any]] {
                        // try to read out a string array
                        print("count for PR =>>>>> \(array.count)")
                        print(array.first ?? "default value")
                        
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    handler(.success(jsonData))
                }
                
            }else {
                let someError = error ?? NSError(domain: "JSON data is nil", code: 0, userInfo: nil)
                DispatchQueue.main.async {
                    handler(.failure(someError as NSError))
                }
            }
        }
        task.resume()
    }
    
    private func encodeRequestParam(param: [String : Any]?) -> Data? {
        
        guard let param = param, !param.isEmpty else {
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: param, options: [])
            return data
        } catch (let error) {
            print(error.localizedDescription)
        }
        return nil;
    }
}
