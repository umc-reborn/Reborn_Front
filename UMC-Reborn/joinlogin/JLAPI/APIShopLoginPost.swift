//
//  APIShopLoginPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import Foundation
import Alamofire


struct Model2:Encodable {
    var userId:String
    var userPwd:String
}

class APIShopLoginPost {
    static let instance = APIShopLoginPost()
    
    func SendingPostShopLogin(parameters1: Model2, handler:@escaping (_ result: ShopModel) ->(Void)){
        let url = "http://www.rebornapp.shop/users/log-in-store"
        let headers:HTTPHeaders = [
            "content-type" : "application/json;charset=utf-8"
        ]
        
        
        AF.request(url, method:.post, parameters: parameters1, encoder: JSONParameterEncoder.default, headers: headers).response { response1 in
            switch response1.result {
            case .success(let data):
                print(String(decoding: data!, as: UTF8.self))
                let resultData2 = String(data: response1.data!, encoding: .utf8)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    print(String(decoding: data!, as: UTF8.self))
                    
                    let jsonresult = try decoder.decode(ShopModel.self, from: data!) // 고쳤음
                    handler(jsonresult)
                    
                }catch {
                    print(String(describing: error)) // 고쳤음
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
        
        
}


struct ShopModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ResultModel2
}

struct ResultModel2: Codable {
    let userIdx: Int
    let storeIdx : Int
    let storeName : String
    let jwt: String
}
