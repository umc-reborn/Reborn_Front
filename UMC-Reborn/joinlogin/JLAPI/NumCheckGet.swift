//
//  NumCheckGet.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/08.
// 본인인증 코드 확인

import Foundation
import Alamofire

class NumCheckGet {
    static let instance = NumCheckGet()
    
    func NumCheckGetData(veriCode: String, handler: @escaping(_ result:NumCheckModel)->(Void)){
        
        let url = "http://www.rebornapp.shop/users/login/mailCheck?code=\(veriCode)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {response6 in switch response6.result {
        case .success(let data):
            print(String(decoding: data!, as: UTF8.self))
            do {
                let jsondata = try JSONDecoder().decode(NumCheckModel.self, from: data!)
                handler(jsondata)
                print(response6)
            } catch {
                print(error.localizedDescription)
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
        }
    }
}

struct NumCheckModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : String // 이 값을 비교해야 함
}
