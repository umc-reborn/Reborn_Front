//
//  CreateRebornPost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/17.
//

import Foundation
import Alamofire

struct CreateRebornModel:Encodable {
    var userIdx:Int
    var rebornIdx:Int
}

class APIHandlerCreateRebornPost {
    static let instance = APIHandlerCreateRebornPost()
    
    func SendingPostReborn(parameters: CreateRebornModel, handler: @escaping (_ result: CreateRebornresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/reborn-task"
        let headers:HTTPHeaders = [
            "content-type": "application/json",
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                print(String(decoding: data!, as: UTF8.self))
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(CreateRebornresultModel.self, from: data!)
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

struct CreateRebornresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:CreateRebornResult
}

struct CreateRebornResult: Codable {
    var rebornTaskIdx: Int
}
