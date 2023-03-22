//
//  RebornStatusModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct RebornStatusList: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [RebornStatusListModel]
}

struct RebornStatusListModel: Codable {
    var rebornTaskIdx: Int
    var userNickname: String
    var productName:String
    var productImg: String?
    var productLimitTime: String
    var productCnt: Int
    var status: String
    var createdAt: String
}
