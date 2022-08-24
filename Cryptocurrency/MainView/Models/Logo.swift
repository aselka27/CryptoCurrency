//
//  Logo.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 16.08.2022.
//

import Foundation

struct Logo: Codable {
    
    enum Keys: String, CodingKey {
        case data = "data"
    }
    let data: [String:Base]
}

struct Base: Codable {
  
    enum BaseKeys: String, CodingKey {
        case logo = "logo"
        case id = "id"
    }
    var logo: String?
    var id: Int
}
