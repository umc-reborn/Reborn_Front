//
//  APIMyRebornPost.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/03.
//

import Foundation
import Alamofire

struct postReviewReqModel:Encodable {
    var userIdx:Int
    var rebornIdx:Int
    var reviewScore:Int
    var reviewComment:String
    var reviewImage:String?
}

class APIMyRebornHandlerPost {
    static let instance = APIMyRebornHandlerPost()
    //
    func SendingPostReview(parameters: postReviewReqModel, handler: @escaping (_ result: [postReviewReqResultModel])->(Void)) {
        let url = "http://www.rebornapp.shop/reviewboni"
        let headers: HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        // ====================
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode([postReviewReqResultModel].self, from: data!)
                    handler(jsonresult)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // ====================
    }
    //
    //
    
}

struct postReviewReqResultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result: postReviewReqResult
}

struct postReviewReqResult: Codable {
    var reviewIdx:Int
}
