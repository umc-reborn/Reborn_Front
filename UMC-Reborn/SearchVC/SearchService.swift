//
//  SearchService.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/03.
//

import Foundation

struct SearchService {
    static let shared = SearchService()
// 1
    let urlString = APIConstants.baseURL + "/store/search?keyword="
//    let clientID = APIConstant.clientID
//    let clientSecret = APIConstant.clientSecret
    
    func SearchData(completion: @escaping (Result<Any, Error>) -> ()) {
// 2
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            var requestURL = URLRequest(url: url)
//            requestURL.addValue(clientID,
//                                forHTTPHeaderField: "x-naver-client-id")
//            requestURL.addValue(clientSecret,
//                                forHTTPHeaderField: "x-naver-client-secret")
// 3
            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(SearchModel.self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
// 4
            dataTask.resume()
        }
    }
}
