//
//  NewShopModel.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/05.
//

import Foundation

struct NewShopModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : [NewShopResponse]
}

struct NewShopResponse : Codable {
    let storeIdx: Int
    let storeImage: String
    let storeName : String
//    let storeAddress: String
//    let storeDescription : String
    let category : String
    let storeScore : Int

}
