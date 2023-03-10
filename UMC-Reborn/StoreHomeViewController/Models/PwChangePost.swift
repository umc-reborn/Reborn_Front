//
//  PwChangePost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/09.
//

import Foundation
import Alamofire

struct PwChangeModel:Encodable {
    var userIdx:Int
    var userPwd:String?
    var userNewPwd:String?
    var userNewPwd2:String?
}

class APIHandlerPwPost {
    static let instance = APIHandlerPwPost()
    
    func SendingPostReborn(token: String, parameters: PwChangeModel, handler: @escaping (_ result: PwChangeresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/users/modifyPwd"
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
                    
                    let jsonresult = try JSONDecoder().decode(PwChangeresultModel.self, from: data!)
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

struct PwChangeresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:String
}
