//
//  APIRebornPatch.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/01.
//

import Foundation
import Alamofire

struct PatchModel:Encodable {
    var rebornIdx: Int
    var status: String
}

class APIHandlerPatch {
    static let instance = APIHandlerPatch()
    
    func SendingPatchReborn(parameters: PatchModel, handler: @escaping (_ result: PatchresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/reborns/task/inactive/11"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(PatchresultModel.self, from: data!)
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

struct PatchresultModel: Codable {
    var isSuccess:Bool
    var code: Int
    var message: String
    var result: String
}
