//
//  RebornHistoryDetailService.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/08.
//

import Foundation
import Alamofire

class RebornHistoryDetailService {
    
    let rebornTaskIdx = UserDefaults.standard.integer(forKey: "rebornTaskIdx")
    
    static let shared = RebornHistoryDetailService()
    private init() {}
     
    func getRebornHistoryDetail(completion: @escaping (NetworkResult<Any>) -> Void) {
        var RebornHistoryDetailUrl = "http://www.rebornapp.shop/reborns/history/detail/\(rebornTaskIdx)"
        print("rebornHistoryDetail의 taskIdx는 \(rebornTaskIdx)")
        let url: String! = RebornHistoryDetailUrl
             let header: HTTPHeaders = [
                // 헤더 프린트 해서 post 형태로 데이터를 불러오는거라서 오키오키
                "Content-type": "application/json"
//                "jwt"
             ]

             let dataRequest = AF.request(
                url, method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: header
             )

        dataRequest.responseData { response in
            dump(response)
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                //                     dump(statusCode)
                // 여기 부분 수정 value
                guard let value = response.value else { return }
                //                     dump(value)
                let networkResult = self.judgeStatus(by: statusCode, value, RebornHistoryDetailModel.self)
                completion(networkResult)
                print("여기까지")
                
            case .failure:
                completion(.networkFail)
                print("여기서")
            }
        }
    }

        private func judgeStatus<T:Codable> (by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
             let decoder = JSONDecoder()
             guard let decodedData = try? decoder.decode(type.self, from: data)
             else { print("decode fail")
                
                return .pathErr }

             /*
              // Decoding = JSON -> Swift object
              do {
                 let decodedData = try JSONDecoder().decode(Student.self, from: studentData)
                 print(decodedData)
              }
              catch let err {
                 print("Failed to decode JSON")
              }*/

             // JSON 데이터를 해독하기 위해 JSONDecoder()를 하나 선언
//             let decoder = JSONDecoder()
//
//             // data를 우리가 만들어둔 PersonDataModel 형으로 decode 해준다.
//             // 실패하면 pathErr로 빼고, 성공하면 decodedData에 값을 뺍니다.
//             guard let decodedData = try? decoder.decode(RebornHistoryDetailModel.self, from: data) else {
//                 print("decode Error")
//                 return .pathErr }
//             // 성공적으로 decode를 마치면 success에다가 data 부분을 담아서 completion을 호출합니다.
//             return .success(decodedData.result)

             switch statusCode {
             case 200 ..< 300: return .success(decodedData as Any)
             case 400 ..< 500: return .pathErr
             case 500: return .serverErr
             default: return .networkFail
             }
         }
   }
