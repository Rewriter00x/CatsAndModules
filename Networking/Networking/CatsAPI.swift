//
//  CatsAPI.swift
//  Networking
//
//  Created by Danylo Burliai on 19.05.2024.
//

import Foundation

public class CatsAPI {
    public static func getCats(url: String) async -> [String]? {
        let req = Request(urlString: url, path: "v1/images/search", params: ["limit":"10"])
        let res: [CatImage]? = await req.processRequest()
        guard let res else {
            return nil
        }
        return res.map { $0.url }
    }
}
