//
//  HTTPManager.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/03.
//

import Foundation
import os

final class HTTPManager {
    static func requestGET(url: String, complete: @escaping (Data) -> ()) {
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = HTTPMethod.get.description
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            guard let response = urlResponse as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                if let response = urlResponse as? HTTPURLResponse {
                    os_log("%@", "\(response.statusCode)")
                }
                return
            }
            
            complete(data)
        }.resume()
    }
    
    static func requestPOST(url: String, encodingData: Data, complete: @escaping (Data) -> ()) {
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = HTTPMethod.post.description
        urlRequest.httpBody = encodingData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("\(encodingData.count)", forHTTPHeaderField: "Content-Length")
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else { return }
            guard let response = urlResponse as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                if let response = urlResponse as? HTTPURLResponse {
                    os_log("%@", "\(response.statusCode)")
                }
                return
            }
            
            complete(data)
        }.resume()
    }
    
    static func requestPATCH(url: String, encodingData: Data, complete: @escaping (Data) -> ()) {
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = HTTPMethod.patch.description
        urlRequest.httpBody = encodingData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("\(encodingData.count)", forHTTPHeaderField: "Content-Length")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                if let response = response as? HTTPURLResponse {
                    os_log("%@", "\(response.statusCode)")
                }
                return
            }
            
            complete(data)
        }.resume()
    }
    
    static func requestDELETE(url: String, encodingData: Data, complete: @escaping (Data) -> ()) {
        guard let validURL = URL(string: url) else { return }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = HTTPMethod.delete.description
        urlRequest.httpBody = encodingData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                return
            }
            
            complete(data)
        }.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
            
        }
    }
}

final class JSONConverter {
    static func decodeJsonArray<T: Codable>(data: Data) -> [T]? {
        do {
            let result = try JSONDecoder().decode([T].self, from: data)
            return result
        } catch {
            guard let error = error as? DecodingError else { return nil }
            switch error {
            case .dataCorrupted(let context):
                print(context.codingPath, context.debugDescription, context.underlyingError ?? "", separator: "\n")
                return nil
            default :
                return nil
            }
        }
    }
    
    static func decodeJson<T: Codable>(data: Data) -> T? {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            guard let error = error as? DecodingError else { return nil }
            switch error {
            case .dataCorrupted(let context):
                print(context.codingPath, context.debugDescription, context.underlyingError ?? "", separator: "\n")
                return nil
            default :
                return nil
            }
        }
    }
    
    static func encodeJson<T: Codable>(param: T) -> Data? {
        do {
            let result = try JSONEncoder().encode(param)
            return result
        } catch {
            return nil
        }
    }
}

struct viewList:Codable {
    let result:[viewListModel]
}

struct viewListModel:Codable {
    let reviewIdx:Int
    let userIdx:Int
    let userImge:String
    let userNickname:String
    let storeName:String
    let storeCategory:String
    let rebornIdx:Int
    let productName:String
    let reviewScore:Int
    let reviewComment:String
    let reviewImage1:String
    let reviewImage2:String
    let reviewImage3:String
    let reviewImage4:String
    let reviewImage5:String
    let reviewCreatedAt:Date
}

final class NetworkManager {
    public static let publicNetworkManager = NetworkManager()
    
    static let identifier = "NetworkManager"
    static let homeDataNotification = "HomeDataNotificationName"
    
    func getHomeData(completion: @escaping (viewList?) -> Void) {
        HTTPManager.requestGET(url: "") { data in
            guard let data: viewList = JSONConverter.decodeJson(data: data) else {
                return
            }
            completion(data)
        }
    }
}
