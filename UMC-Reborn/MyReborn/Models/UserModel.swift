//
//  UserModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/19.
//

import Foundation

struct UserList : Codable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : UserListModel
}

struct UserListModel : Codable {
    var userImg : String?
    var userNickname : String
    var userAddress : String
    var userBirthDate : String
    var userLikes : String
}
