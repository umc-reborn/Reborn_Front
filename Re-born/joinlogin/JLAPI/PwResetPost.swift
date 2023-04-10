//
//  PwResetPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/15.
//

import Foundation
import Alamofire

struct PwResetModel:Encodable {
    var userId: String
    var userEmail: String
    var userPwd: String
}

class APIHandlerResetPost {
    static let instance = APIHandlerResetPost()
    
    func SendingPostReborn(parameters: PwResetModel, handler: @escaping (_ result: PwResetresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/users/pwd-reset"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                print(String(decoding: data!, as: UTF8.self))
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(PwResetresultModel.self, from: data!)
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

struct PwResetresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:String
}

