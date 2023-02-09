//
//  RebornStatusModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct RebornStatusList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [RebornStatusListModel]
}

struct RebornStatusListModel: Codable {
    let rebornTaskIdx: Int
    let userNickname: String
    let productName:String
    let productImg: String?
    let productLimitTime: String
    let productCnt: Int
    let status: String
    let createdAt: String
}
