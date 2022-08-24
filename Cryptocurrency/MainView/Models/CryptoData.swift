//
//  ApiResponse.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 6.08.2022.
//

import Foundation

struct CryptoData: Codable {
    var data: [Crypto] = []
}

struct Crypto: Codable {
    var name: String
    var symbol: String
    var id: Int
    var quote: Quote
    
    enum CodingKeys: String, CodingKey {
        case name, symbol, id, quote
    }
}

struct Quote: Codable {
    var currency: Usd
    
    enum CodingKeys: String, CodingKey {
        case currency = "USD"
    }
}

struct Usd: Codable {
    var price: Float
    var percentChange: Float
    var volume: Float
    var marketCap: Float
    
    enum CodingKeys: String, CodingKey {
        case price
        case percentChange = "percent_change_24h"
        case volume = "volume_24h"
        case marketCap = "market_cap"
    }
}







  
