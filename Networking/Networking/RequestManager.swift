//
//  RequestManager.swift
//  Networking
//
//  Created by Danylo Burliai on 19.05.2024.
//

import Foundation

class Request {
    private let urlString: String
    private let path: String
    private let params: Dictionary<String, String>
    
    public init(urlString: String, path: String, params: Dictionary<String, String>) {
        self.urlString = urlString
        self.path = path
        self.params = params
    }
    
    func processRequest<T: Codable>() async -> T? {
        let url = URL(string: urlString)
        guard var url else {
            print("Failed to make url for request \(urlString)")
            return nil
        }
        
        url.append(path: path)
        
        let items: [URLQueryItem] = params.map { (key, value) in
            return URLQueryItem(name: key, value: value)
        }
        
        url.append(queryItems: items)
        
        let res = try? await URLSession.shared.data(from: url)
        guard let res else {
            print("Didn't get result from url session \(url)")
            return nil
        }
        
        let ret = try? JSONDecoder().decode(T.self, from: res.0)
        guard let ret else {
            print("Could not decode result \(res)")
            return nil
        }
        
        return ret
    }
}
