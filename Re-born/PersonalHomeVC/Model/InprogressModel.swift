//
//  OngingModel.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/09.
//

import Foundation

struct InprogressModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : [InprogressResponse]
}

struct InprogressResponse : Codable {
    let rebornTaskIdx: Int
    let rebornIdx: Int
    let storeIdx: Int
    let productName : String
    let storeName : String
    let category : String
    let productImg : String?
    let productLimitTime : String
    let productCnt: Int
    
//    "rebornTaskIdx": 1,
//       "rebornIdx": 4,
//       "storeIdx": 1,
//       "storeName": "빵카페",
//       "category": "CAFE",
//       "productName": "베이컨 샌드위치",
//       "productImg": "",
//       "productLimitTime": "00:00:00",
//       "productCnt": 2

}
