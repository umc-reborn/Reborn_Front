//
//  APIHandlerGet.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/30.
//

import Foundation

struct RebornList : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : [RebornListModel]
}

struct RebornListModel : Codable {
    let rebornIdx : Int
    let productName : String
    let productGuide : String
    let productComment : String
    let productImg : String?
    let productLimitTime : String
    let productCnt : Int
    let status : String
}
