//
//  RebornCancelPost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/02.
//

import Foundation
import Alamofire

struct RebornCancelModel:Encodable {
    var rebornTaskIdx:Int
}

class APIHandlerCancelPost {
    static let instance = APIHandlerCancelPost()
    
    func SendingPostReborn(rebornTaskId: Int, parameters: RebornCancelModel, handler: @escaping (_ result: RebornCancelresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/reborns/task/inactive/\(String(rebornTaskId))"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(RebornCancelresultModel.self, from: data!)
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

struct RebornCancelresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:String
}

