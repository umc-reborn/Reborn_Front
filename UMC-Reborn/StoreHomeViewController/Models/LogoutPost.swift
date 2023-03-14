//
//  LogoutPost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/11.
//

import Foundation
import Alamofire

struct LogoutModel:Encodable {
    var jwt:String
}

class APIHandlerLogoutPost {
    static let instance = APIHandlerLogoutPost()
    
    func SendingPostReborn(token: String, parameters: LogoutModel, handler: @escaping (_ result: LogoutresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/users/log-out"
        let headers:HTTPHeaders = [
            "content-type": "application/json",
            "X-ACCESS-TOKEN": "\(token)"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(LogoutresultModel.self, from: data!)
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

struct LogoutresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:LogoutResult
}

struct LogoutResult: Codable {
    var userIdx:Int
    var userNickname:String
    var jwt:String
}
