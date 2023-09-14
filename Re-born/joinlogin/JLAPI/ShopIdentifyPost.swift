//
//  ShopIdentifyPost.swift
//  Re-born
//
//  Created by jaegu park on 13/09/23.
//

import Foundation
import Alamofire

struct ShopIdentifyModel:Encodable {
    var b_no: String
}

class APIHandlerShopPost {
    static let instance = APIHandlerShopPost()
    
    func SendingPostReborn(parameters: ShopIdentifyModel, handler: @escaping (_ result: ShopIdentifyresultModel)->(Void)) {
        let url = "api.odcloud.kr/api/nts-businessman/v1/status"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                print(String(decoding: data!, as: UTF8.self))
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(ShopIdentifyresultModel.self, from: data!)
                    handler(jsonresult)
                    print(jsonresult)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ShopIdentifyresultModel: Codable {
    var status_code: String
    var match_cnt: Int
    var request_cnt: String
    var data: IdentifyResult
}

struct IdentifyResult: Codable {
    var b_no: String
    var b_stt: String
    var b_stt_cd: String
    var tax_type: String
    var tax_type_cd: String
    var end_dt: String
    var utcc_yn: String
    var tax_type_change_de: String
    var invoice_apply_dt: String
    var rbf_tax_type: String
    var rbf_tax_type_cd: String
}
