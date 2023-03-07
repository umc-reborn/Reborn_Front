//
//  APIImagePost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/10.
//

import Foundation
import Alamofire

struct ImageModel:Encodable {
    var file: Data
}
//
class APIHandlerImagePost {
    static let instance = APIHandlerImagePost()

    func SendingPostImage(parameters: ImageModel, handler: @escaping (_ result: ImageresultModel)->(Void)) {
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

                    let jsonresult = try JSONDecoder().decode(ImageresultModel.self, from: data!)
                    handler(jsonresult)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ImageresultModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String?
}
