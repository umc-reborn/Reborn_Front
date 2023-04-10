//
//  idCheckGet.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/15.
// 아이디 중복확인 api

import Foundation

struct IdCheckList : Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:String
}

struct IdCheckService {
    static let shared = IdCheckService()
    
    let urlString = APIConstants.baseURL + "/users/checkDuplicate?userId={userId}"
    
    func IdCheckData(completion: @escaping (Result<Any, Error>) -> ()) {
        
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
                        let decodedData = try JSONDecoder().decode(IdCheckList.self, from: safeData)
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
