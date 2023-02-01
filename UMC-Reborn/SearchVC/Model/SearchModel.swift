//
//  SearchModel.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/31.
//

import Foundation

struct SearchResponse : Codable {
    let storeIdx: String
    let storeName : String
    let storeImage: String
    let storeAddress: String
    let storeDescription : String
    let storeScore : Int
    let category : String
    
    enum CodingKeys : String, CodingKey {
        case storeIdx
        case storeName
        case storeImage
        case storeAddress
        case storeDescription
        case storeScore
        case category
    }
}
