//
//  UserModel.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/03/22.
//

import Foundation

struct UserList : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : UserListModel
}

struct UserListModel: Codable {
    var userImg: String?
    var userNickname: String
    var userAddress: String
    var userLikes: String
}
