//
//  FindIdGet.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/27.
// 아이디 찾기 - 부분

import Foundation
import Alamofire

class FindIdGet {
    static let instance = FindIdGet()
    
    func FindIdGetData(userEmail : String, handler: @escaping(_ result:FindPartModel)->(Void)){
    
        let url = "http://www.rebornapp.shop/users/IdFindPart?email=\(userEmail)"
        AF.request(url, method:.get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response5 in
            switch response5.result {
        case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(FindPartModel.self, from: data!)
                    handler(jsondata)
                    //print(jsondata)
                    print(response5)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct FindPartModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : FindResultModel
}

struct FindResultModel : Codable {
    let userId : String
    let createdAt : String
}
