//
//  PopularShopModel.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/07.
//

import Foundation

struct PopularShopModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : [PopularShopResponse]
}

struct PopularShopResponse : Codable {
    let storeIdx: Int
    let storeAddress: String
    let storeName : String
    let category : String
    let storeScore : Float
    let storeImage : String

}
