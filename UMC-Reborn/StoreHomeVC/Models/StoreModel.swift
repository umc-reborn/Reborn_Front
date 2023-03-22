//
//  StoreModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/05.
//

import Foundation

struct StoreList : Codable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : StoreListModel
}

struct StoreListModel : Codable {
    var storeIdx : Int
    var storeName : String
    var storeImage : String?
    var userImage : String?
    var storeAddress : String
    var storeDescription : String
    var storeScore : Float
    var numOfReborn : Int
    var numOfJjim : Int
    var numOfReview: Int
    var category : String
}
