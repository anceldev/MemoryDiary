//
//  User.swift
//  MemoryDiary
//
//  Created by Ancel Dev account on 14/9/24.
//

import Foundation

final class User: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "$id"
        case name, email, password
    }
    
    init(id: String, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
