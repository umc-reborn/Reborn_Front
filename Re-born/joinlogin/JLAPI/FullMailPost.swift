//
//  FullMailPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/11.
// 아이디찾기-메일전송

import Foundation
import Alamofire

struct EModel : Encodable {
    var userEmail : String
}

class FullMailPost {
    static let instance = FullMailPost()
    
    func sendingPostFullEmail(parameters: EModel, handler:@escaping (_ result: TTrainModel) -> (Void)){
        let url = "http://www.rebornapp.shop/users/IdFindMail"
        let headers:HTTPHeaders = [
            "content-type" : "application/json;charset=utf-8"
        ]
        
        AF.request(url, method: .post, parameters: parameters,encoder: JSONParameterEncoder.default, headers: headers).response {response7 in switch response7.result {
        case .success(let data):
            print(String(decoding: data!, as: UTF8.self))
            let resultData8 = String(data: response7.data!, encoding: .utf8)
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                print(json)
                
                
                let jsonresult = try
                JSONDecoder().decode(TTrainModel.self, from: data!)
                handler(jsonresult)
            }catch {
                print(String(describing:error))
            }
        case .failure(let error):
            print(String(String(describing: error)))
        }
        }
    }
    
}

struct TTrainModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : String
}

