//
//  RebornHistoryService.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/08.
//

import Foundation
import Alamofire

class RebornHistoryService {

    var RebornHistoryUrl = "http://www.rebornapp.shop/reborns/history/1"
    
    static let shared = RebornHistoryService()
    private init() {}
     
    func getRebornHistory(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url: String! = RebornHistoryUrl
             let header: HTTPHeaders = ["Content-type": "application/json"]

             let dataRequest = AF.request(
                url, method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: header
             )

             dataRequest.responseData { response in
//                 dump(response)
                 switch response.result {
                 case .success:
                     guard let statusCode = response.response?.statusCode else { return }
//                     dump(statusCode)
                     guard let value = response.value else { return }
//                     dump(value)
                     let networkResult = self.judgeStatus(by: statusCode, value, RebornHistoryModel.self)
                     completion(networkResult)
//                     print("여기까지")

                 case .failure:
                     completion(.networkFail)
//                     print("여기서")
                 }
             }
         }

         private func judgeStatus<T:Codable> (by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
             let decoder = JSONDecoder()
             guard let decodedData = try? decoder.decode(type.self, from: data)
             else { print("여기인가봐")
                 return .pathErr }

             switch statusCode {
             case 200 ..< 300: return .success(decodedData as Any)
             case 400 ..< 500: return .pathErr
             case 500: return .serverErr
             default: return .networkFail
             }
         }
   }
