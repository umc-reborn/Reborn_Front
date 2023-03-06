//
//  RebornActivePost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/02.
//

import Foundation
import Alamofire

struct RebornActiveModel:Encodable {
    var rebornIdx:Int
}

class APIHandlerActivePost {
    static let instance = APIHandlerActivePost()
    
    func SendingPostReborn(rebornId: Int, parameters: RebornActiveModel, handler: @escaping (_ result: RebornActiveresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/reborns/active/\(String(rebornId))"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(RebornActiveresultModel.self, from: data!)
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

struct RebornActiveresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result: RebornActiveResult
}

struct RebornActiveResult: Codable {
    var rebornIdx:Int
    var productName:String
}
