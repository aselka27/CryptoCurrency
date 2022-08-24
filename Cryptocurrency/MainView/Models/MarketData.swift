//
//  LineData.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 22.08.2022.
//

import Foundation

struct MarketData: Decodable {
    let symbol: String
    let high_24h: Double
    let low_24h: Double
    let sparkline_in_7d: Price
    let image: String
}

struct Price: Decodable {
  let price: [Double]
}
