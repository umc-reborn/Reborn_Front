//
//  APIConstants.swift
//  Re-born
//
//  Created by jaegu park on 11/09/23.
//

import Foundation

struct APIConstants {
    // MARK: - Base URL
    static let baseURL = "http://www.rebornapp.shop"
    
    // MARK: - newShop URL
    static let newStoreURL = baseURL + "/store/new"
    
    // MARK: - Review URL
    static let reviewURL = baseURL + "/review/best"
    
    static let inprogressURL = baseURL + "/reborns/inprogress/user/"
    
    static let willLikeshopURL = baseURL + "/store/likeable-stores"
}
