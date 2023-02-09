//
//  StoreService.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/05.
//

import Foundation

struct StoreService {
    static let shared = StoreService()
    
    let urlString = APIConstants.baseURL + "/store/9"
    
    func StoreData(completion: @escaping (Result<Any, Error>) -> ()) {
        
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
                        let decodedData = try JSONDecoder().decode(StoreList.self, from: safeData)
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
