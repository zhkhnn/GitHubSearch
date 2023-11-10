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
