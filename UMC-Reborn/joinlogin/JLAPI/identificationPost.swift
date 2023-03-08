// 이웃 회원가입 - 본인인증 API
//  identificationPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/11.
//

import Foundation
import Alamofire

struct Model3: Encodable {
    var userEmail:String
}

class identificationPost {
    static let instance = identificationPost()
    
    func SendingPostNemail(parameters2: Model3, handler:@escaping (_ result: emailModel) ->(Void)){
        let url = "http://www.rebornapp.shop/users/login/mailConfirm"
        let headers:HTTPHeaders = [
            "content-type" : "application/json;charset=utf-8"
        ]
        
        AF.request(url, method:.post, parameters: parameters2, encoder:
                    JSONParameterEncoder.default, headers: headers).response { ressponse in switch ressponse.result {
                    case .success(let data):
                        //let resultData3 = String(data: ressponse.data!, encoding: .utf8)
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                            print(json) // {} 로그에 뜬 애들
                            
                            let jsonresult = try JSONDecoder().decode(emailModel.self, from: data!)
                            handler(jsonresult) // 디코드 한 것
                            print(jsonresult) // 프린트 됨  여기서 result 값 꺼내오기 
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
    let message: String
    let result: String
    }
