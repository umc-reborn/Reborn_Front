//
//  RebornModel.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/20.
//

import Foundation


struct RebornList : Codable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [RebornListModel]
}

struct RebornListModel : Codable {
    var rebornIdx : Int
    var productName : String
    var productGuide : String
    var productComment : String
    var productImg : String?
    var productLimitTime : String
    var productCnt : Int
    var status : String
}
