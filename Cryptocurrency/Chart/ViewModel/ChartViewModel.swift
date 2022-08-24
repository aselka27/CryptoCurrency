//
//  ChartViewModel.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 15.08.2022.
//

import Foundation

protocol ChartViewModelProtocol {
    var cryptoModel: CryptoData {get set}
    var callBack: ((_ data: CryptoData) -> ())? {get set}
    func getData()
}

class ChartViewModel: ChartViewModelProtocol {
    
    // MARK: - Properties
    let networkManager = NetworkManager()
    var callBack: ((_ data: CryptoData) -> ())?
    var cryptoModel = CryptoData()
    
    // MARK: - Fetch crypto data
    func getData() {
        networkManager.decodeCryptoData() { [weak self] data in
            self?.cryptoModel = data
            self?.callBack?(data)
        }
    }
}
