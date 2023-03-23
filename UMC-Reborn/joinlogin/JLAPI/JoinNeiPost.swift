//
//  JoinNeiPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/18.
// 이웃 회원가입!!!!!

import Foundation
import Alamofire

struct BigModel: Encodable {
    var userId: String
    var userEmail: String
    var userPwd: String
    var userNickname: String
    var userImg: String
    var userAdAgreement: String
    var userBirthDate: String
    var userAddress: String
    var userLikes: String
}

class JoinNeiPost {
    static let instance = JoinNeiPost()
    
    func SendingPostNeiJoin(parameterspp: BigModel, handler:@escaping (_ result: realFinModel) ->(Void)){
        let url = "http://www.rebornapp.shop/users/sign-up"
        let headers:HTTPHeaders = [
            .contentType("application/json;charset=utf-8") 
        ]
        
        AF.request(url, method:.post, parameters: parameterspp, encoder: JSONParameterEncoder.default, headers: headers).response { rresponse in
            switch rresponse.result {
            case .success(let data):
                print(String(decoding: data!, as: UTF8.self))
                let resultData = String(decoding: data!, as: UTF8.self)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try
                    JSONDecoder().decode(realFinModel.self, from: data!)
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
    
struct realFinModel: Codable {
    let isSuccess: Bool
    let code : Int
    let message : String
    let result : jjinModel
}

struct jjinModel: Codable {
    let userIdx: Int
    let userNickName: String
    let jwt: String
}
