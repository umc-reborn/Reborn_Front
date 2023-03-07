//
//  FindIdPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/27.
//

import Foundation
import Alamofire

struct FindIdModel:Encodable {
    var userEmail: String
}

class FindIdPost {
    static let instance = identificationPost()
    
    func SendingEmailPost(parameters6:FindIdModel, handler:@escaping (_ result: aaaModel)->(Void)){
        let url = "http://www.rebornapp.shop/users/IdFindMail"
        let headers:HTTPHeaders = [
            "content-type" : "application/json;charset=utf-8"
        ]
        
        AF.request(url, method: .post, parameters: parameters6, encoder: JSONParameterEncoder.default, headers: headers).response {response4 in switch response4.result{
        case .success(let data):
            let resultData7 = String(data: response4.data!, encoding: .utf8)
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                print(json)
                
                let jsonresult = try
                JSONDecoder().decode(aaaModel.self, from: data!)
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

struct aaaModel: Codable {
    let isSuccess: Bool
    let code : Int
    let message : String
    let result : String
}
