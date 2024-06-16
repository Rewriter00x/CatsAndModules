//
//  Storage.swift
//  CatsViewer
//
//  Created by Danylo Burliai on 19.05.2024.
//

import Foundation
import Networking
import FirebasePerformance

class Storage: ObservableObject {
    static var instance = Storage()
    
    static let catsAPI = "https://api.thecatapi.com/"
    static let dogsAPI = "https://api.thedogapi.com/"
    
    static func getUrl() -> String {
        guard let appMode = Bundle.main.object(forInfoDictionaryKey: "AppMode") as? String else {
            return catsAPI
        }
        
        return appMode == "DOGS" ? dogsAPI : catsAPI
    }
    
    private init() {
        Task {
            let trace = Performance.startTrace(name: "REST_REQUEST_TIME")
            trace?.start()
            let res = await CatsAPI.getCats(url: Storage.getUrl()) ?? []
            DispatchQueue.main.async {
                self.urls = res
                trace?.stop() // not sure how else to track async readiness, but yeah, this adds overhead to trace
            }
        }
    }
    
    @Published var urls: [String] = []
}
