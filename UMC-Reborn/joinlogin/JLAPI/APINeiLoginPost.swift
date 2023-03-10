//
//  APINeiLoginPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import Foundation
import Alamofire


struct Model1:Encodable {
    var userId:String
    var userPwd:String
}

class APINeiLoginPost {
    static let instance = APINeiLoginPost()
    
        func SendingPostNLogin(parameters: Model1, handler:@escaping (_ result: TrainModel) ->(Void)){
            let url = "http://www.rebornapp.shop/users/log-in"
            let headers:HTTPHeaders = [
                .contentType("application/json;charset=utf-8") // 고쳤음
            ]
            
            AF.request(url, method:.post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { rresponse in
                switch rresponse.result {
                case .success(let data):
                    let resultData = String(data: rresponse.data!, encoding: .utf8)
                    //let encodingEUCKR = CFStringConvertEncodingToNSStringEncoding(0x0422)
                    //let strUTF8 = String(data: data!, encoding: String.Encoding(rawValue: encodingEUCKR))
                    do {
//                        var dataString = NSString(data: data!, encoding: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue)))
                        let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                        print(json)
                        
                        let jsonresult = try JSONDecoder().decode(TrainModel.self, from: data!) // 고쳤음
                        //let something = jsonresult.result
                        handler(jsonresult)
                        
                    }catch let error as NSError {
                        print(String(describing: error)) // 고쳤음
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
    
}

struct TrainModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ResultModel
    
}

struct ResultModel: Codable {
    let userIdx: Int
    let userNickname : String
    let jwt: String
}
