//
//  APIJjimPost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/03.
//

import Foundation
import Alamofire

struct JjimModel:Encodable {
    var storeIdx:Int
    var userIdx:Int
}

class APIHandlerJjimPost {
    static let instance = APIHandlerJjimPost()
    
    func SendingPostJjim(parameters: JjimModel, handler: @escaping (_ result: JjimresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/jjim"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(JjimresultModel.self, from: data!)
                    handler(jsonresult)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct JjimresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result: JjimResult
}

struct JjimResult: Codable {
    var jjimIdx:Int
    var userEmail:String
    var storeName:String
}
