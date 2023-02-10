//
//  ReviewService.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct ReviewService {
    static let shared = ReviewService()
    
    let urlString = APIConstants.baseURL + "/review/store/{storeIdx}"
    
    func RebornStatusData(completion: @escaping (Result<Any, Error>) -> ()) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            var requestURL = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(ReviewList.self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}

struct ReviewImageService {
    static let shared = ReviewImageService()
    
    let urlString = APIConstants.baseURL + "/review/store/{storeIdx}"
    
    func RebornStatusData(completion: @escaping (Result<Any, Error>) -> ()) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            var requestURL = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(ReviewStoreList.self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}



struct ReviewCountService {
    static let shared = ReviewCountService()
    
    let urlString = APIConstants.baseURL + "/review/cnt?storeIdx={storeIdx}"
    
    func RebornStatusData(completion: @escaping (Result<Any, Error>) -> ()) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            var requestURL = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(ReviewCountList.self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
