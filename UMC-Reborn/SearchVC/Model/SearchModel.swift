//
//  SearchModel.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/31.
//

import Foundation


struct SearchModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : [SearchResponse]
}

struct SearchResponse : Codable {
    let storeIdx: Int
    let storeName : String
    let userImage: String
    let storeAddress: String
    let storeDescription : String
    let storeScore : Float
    let category : String
}
