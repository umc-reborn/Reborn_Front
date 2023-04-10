//
//  BestReviewService.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/05.
//

import Foundation
import Alamofire

class BestReviewService {
    
    static let shared = BestReviewService()
    private init() {}
    
    
    func getBestReview(completion: @escaping (NetworkResult<Any>) -> Void) {
//        let firstObject: SearchResultViewController = .init()
        let url: String! = APIConstants.reviewURL
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
                     let networkResult = self.judgeStatus(by: statusCode, value, BestReviewModel.self)
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
