//
//  StoreEditPost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/02.
//

import Foundation
import Alamofire

struct StoreEditModel:Encodable {
    var storeName: String?
    var storeAddress: String?
    var storeDescription: String?
    var category: String?
    var storeImage: String?
}

class APIHandlerStorePost {
    static let instance = APIHandlerStorePost()
    
    func SendingPostReborn(storeId: Int, parameters: StoreEditModel, handler: @escaping (_ result: StoreEditresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/store/update/\(String(storeId))"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(StoreEditresultModel.self, from: data!)
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

struct StoreEditresultModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: StoreEditResult
}

struct StoreEditResult: Codable {
    var storeIdx: Int
}
