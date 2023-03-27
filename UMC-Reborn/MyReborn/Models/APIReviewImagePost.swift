//
//  APIReviewImagePost.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/26.
//

import Foundation
import Alamofire

struct ReviewImageModel:Encodable {
    var file: Data
}

class APIHandlerReviewImagePost {
    static let instance = APIHandlerReviewImagePost()

    func SendingPostReviewImage(parameters: ReviewImageModel, handler: @escaping (_ result: ReviewImageresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/s3"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]

        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)

                    let jsonresult = try JSONDecoder().decode(ReviewImageresultModel.self, from: data!)
                    handler(jsonresult)
                    print("image URL 붙이기 성공")
                } catch {
                    print(error.localizedDescription)
                    print("image URL 붙이기 error")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("image URL 붙이기 실패")
            }
        }
    }
}

struct ReviewImageresultModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String
}

