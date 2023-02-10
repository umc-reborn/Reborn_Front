//
//  StoreModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/05.
//

import Foundation

struct StoreList : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : StoreListModel
}

struct StoreListModel : Codable {
    let storeIdx : Int
    let storeName : String
    let storeImage : String?
    let storeAddress : String
    let storeDescription : String
    let storeScore : Int
    let category : String
}
