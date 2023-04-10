//
//  RebornDeletePost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/02.
//

import Foundation
import Alamofire

struct RebornDeleteModel:Encodable {
    var rebornIdx:Int
}

class APIHandlerDeletePost {
    static let instance = APIHandlerDeletePost()
    
    func SendingPostReborn(rebornId: Int, parameters: RebornDeleteModel, handler: @escaping (_ result: RebornDeleteresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/reborns/delete/\(String(rebornId))"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(RebornDeleteresultModel.self, from: data!)
                    handler(jsonresult)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct RebornDeleteresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:String
}
