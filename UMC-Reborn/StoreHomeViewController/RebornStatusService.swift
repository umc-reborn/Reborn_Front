//
//  RebornStatusService.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct RebornStatusService {
    static let shared = RebornStatusService()
    
    let urlString = APIConstants.baseURL + "/reborns/store/page/{storeIdx}/status?status="
    
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
                        let decodedData = try JSONDecoder().decode(RebornStatusList.self, from: safeData)
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
