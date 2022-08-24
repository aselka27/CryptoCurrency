//
//  NetworkManager.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 6.08.2022.
//

import Foundation


class NetworkManager {
    
    
    // MARK: - Api
    private static let coinCapApiHost = "https://pro-api.coinmarketcap.com/"
    private static let coinGeckoApi = "https://api.coingecko.com/api/"
    private let coinCapApiKey = "58a10bf3-8ddd-4c98-85ff-401bfa47471e"
    private let latestListingParameters = "?sort=market_cap&limit=10"
    
    
    // MARK: - Endpoints & Parameters
    enum CoinCapEndpoints: String {
        case latestListing = "v1/cryptocurrency/listings/latest"
        case metaData = "v2/cryptocurrency/info"
        
        var url: String {
            return NetworkManager.coinCapApiHost + self.rawValue + Parameters.latestListing.rawValue
        }
    }
    
    enum CoinGeckoEndPoint: String {
        case marketData = "v3/coins/markets"
        var url: String {
            return NetworkManager.coinGeckoApi + self.rawValue+Parameters.marketData.rawValue
        }
    }
    enum Parameters: String {
        case latestListing = "?sort=market_cap&limit=10"
        case marketData = "?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true"
    }
    
    // MARK: - Fetching data
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    } ()
    
    private func getLatestListings (
        completion: @escaping (Result<Data, Error>) -> Void) {
            
            // Configure api
            guard let url = URL(string: CoinCapEndpoints.latestListing.url) else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("\(coinCapApiKey)", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
            
            // GET request
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error occured")
                        completion(.failure(error))
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        print(response.debugDescription)
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    completion(.success(data))
                }
            }.resume()
        }
    
    
    private func getMarketData (
        completion: @escaping (Result<Data, Error>) -> Void) {
            guard let url = URL(string: CoinGeckoEndPoint.marketData.url ) else { return }
            let urlRequest = URLRequest(url: url)
            
            // GET request
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error occured")
                        completion(.failure(error))
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        print(response.debugDescription)
                        return
                    }
                    
                    guard let data = data else {
                        return
                    }
                    completion(.success(data))
                    print("success fetching")
                    print(data)
                    
                }
            }.resume()
        }
    
    // MARK: - Decode Latest Listings
    public func decodeCryptoData (
        response: @escaping (CryptoData)->Void) {
            
            getLatestListings() { result in
                switch result {
                case .success(let data):
                    do {
                        let decodedData = try self.jsonDecoder.decode(CryptoData.self, from: data)
                        response(decodedData)
                    }
                    catch let jsonError{
                        print("Parsing error", jsonError)
                    }
                case .failure(let error):
                    print("Error has occured\(error.localizedDescription)")
                }
            }
        }
    
    // MARK: - Decode Chart Data
    public func decodeChartData (response: @escaping (_ chartData: [MarketData])->Void) {
        getMarketData() { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try self.jsonDecoder.decode([MarketData].self, from: data)
                    response(decodedData)
                    print("successDecoding")
                }
                catch let jsonError{
                    print("Parsing error", jsonError)
                }
            case .failure(let error):
                print("Error has occured\(error.localizedDescription)")
            }
        }
    }
}
