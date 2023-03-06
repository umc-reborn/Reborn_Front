//
//  RebornEditPost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/02.
//

import Foundation
import Alamofire

struct RebornEditModel:Encodable {
    var storeIdx:Int
    var productName:String?
    var productGuide:String?
    var productComment:String?
    var productImg:String?
    var productLimitTime:String?
    var productCnt:Int
}

class APIHandlerEditPost {
    static let instance = APIHandlerEditPost()
    
    func SendingPostReborn(parameters: RebornEditModel, handler: @escaping (_ result: RebornEditresultModel)->(Void)) {
        let url = "http://www.rebornapp.shop/reborns/modify"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(RebornEditresultModel.self, from: data!)
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

struct RebornEditresultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:String
}
