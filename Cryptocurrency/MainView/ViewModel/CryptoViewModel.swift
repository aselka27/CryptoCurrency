//
//  CryptoViewModel.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 6.08.2022.
//

import Foundation
import UIKit

protocol CryptoViewModelProtocol {
    var cryptoModel: CryptoData {get set}
    var callBack: (()->())? { get set }
    func getData()
    func getCoinLogos()
    var masterData: [MarketData] {get set}
    func setTextColor(label change24H: UILabel, change num: Float)
}

class CryptoViewModel: CryptoViewModelProtocol {
    
    // MARK: - Properties
    private let negative: UIColor = .systemRed
    private let positive: UIColor = .systemGreen
    let networkManager = NetworkManager()
    var callBack: (() -> ())?
    var cryptoModel = CryptoData()
    var masterData: [MarketData] = []
    
    // MARK: - Fetch crypto data
    func getData() {
        networkManager.decodeCryptoData() { [weak self] data in
            self?.cryptoModel = data
            self?.callBack?()
        }
    }
    
    // MARK: - Fetch coin logos
    func getCoinLogos() {
        networkManager.decodeChartData { [weak self] chartData in
            self?.masterData = chartData
            self?.callBack?()
        }
    }
    // MARK: - Change "percent change" color
    func setTextColor(label change24H: UILabel, change num: Float) {
        if num > 0 {
            change24H.backgroundColor = positive
        } else {
            change24H.backgroundColor = negative
        }
    }
}

