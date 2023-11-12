//
//  User.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import Foundation
struct User: Decodable, Identifiable{
    let id: Int
    let login: String
    let avatar_url : String
    
    enum CodingKeys: String, CodingKey{
        case id
        case login
        case avatar_url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatar_url = try container.decode(String.self, forKey: .avatar_url)
    }
}
extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
        try container.encode(avatar_url, forKey: .avatar_url)
        
    }
}
