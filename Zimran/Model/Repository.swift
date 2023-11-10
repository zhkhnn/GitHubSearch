//
//  Repository.swift
//  Zimran
//
//  Created by Aruzhan Zhakhan on 05.11.2023.
//

import Foundation
struct Repository: Identifiable, Decodable {
    var id: Int
    let name: String
    let stargazers_count: Int
    let forks_count: Int
    let created_at: String
    let owner: User
    

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stargazers_count
        case forks_count
        case created_at
        case owner
    }
    init(id: Int, name: String, stargazers_count: Int, forks_count: Int, created_at: String, owner: User) {
        self.id = id
        self.name = name
        self.stargazers_count = stargazers_count
        self.forks_count = forks_count
        self.created_at = created_at
        self.owner = owner
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.stargazers_count = try container.decode(Int.self, forKey: .stargazers_count)
        self.forks_count = try container.decode(Int.self, forKey: .forks_count)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.owner = try container.decode(User.self, forKey: .owner)
    }
}


