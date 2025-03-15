//
//  EditUserInfoPost.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/03/22.
//

import Foundation
import Alamofire

struct EditUserInfoModel: Encodable {
    var userImg: String?
    var userNickname: String?
    var userAddress: String?
    var userLikes: String?
}

class APIHandlerUserInfoPost {
    static let instance = APIHandlerUserInfoPost()
    
    func SendingPostReborn(token: String, parameters: EditUserInfoModel, handler: @escaping (_ result: EditUserInfoResultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/users/userModify"
        
        
        
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
                    
                    let jsonresult = try JSONDecoder().decode(EditUserInfoResultModel.self, from: data!)
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


struct EditUserInfoResultModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String
}
