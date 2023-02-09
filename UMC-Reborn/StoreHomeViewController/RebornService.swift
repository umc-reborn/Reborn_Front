//
//  RebornService.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/05.
//

import Foundation

struct RebornService {
    static let shared = RebornService()
    
    let urlString = APIConstants.baseURL + "/reborns/store/{storeIdx}/status?status="
    
    func RebornData(completion: @escaping (Result<Any, Error>) -> ()) {
        
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
                        let decodedData = try JSONDecoder().decode(RebornList.self, from: safeData)
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
