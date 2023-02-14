// 이웃 회원가입 - 본인인증 API
//  identificationPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/11.
//

import Foundation
import Alamofire

struct Model3: Encodable {
    var email:String
}

class identificationPost {
    static let instance = identificationPost()
    
    func SendingPostNemail(parameters2: Model3, handler:@escaping (_ result: emailModel) ->(Void)){
        
        let url = "http://www.rebornapp.shop/users/login/mailConfirm?userEmail={유저이메일}"
        let headers:HTTPHeaders = [
            .contentType("application/json;charset=utf-8")
        ]
        
        AF.request(url, method:.post, parameters: parameters2, encoder:
                    JSONParameterEncoder.default, headers: headers).response { ressponse in switch ressponse.result {
                    case .success(let data):
                        let resultData3 = String(data: ressponse.data!, encoding: .utf8)
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                            print(json)
                            
                            let jsonresult = try JSONDecoder().decode(emailModel.self, from: data!)
                            handler(jsonresult)
                            
                        }catch {
                            print(String(describing: error))
                        }
                    case .failure(let error):
                        print(String(describing: error))
                    }
            }
    }

}

struct emailModel : Codable {
    let isSuccess : Bool
    let code : Int
    let Message: String
    let result: String
    }
