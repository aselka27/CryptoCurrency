//
//  FloatExtension.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 10.08.2022.
//

import Foundation
import UIKit
import Kingfisher

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}

extension MainViewController {
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        formatter.currencySymbol = "$"
        
        return formatter
    } ()
    
    static let volumeFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        
        return formatter
    } ()
    
    func getCellData(with viewModel: CryptoViewModelProtocol, for indexPath: IndexPath, cell: CurrencyTableViewCell) {
        
        let crypto = viewModel.cryptoModel.data[indexPath.row]
        
        // Format values
        let formattedChange = crypto.quote.currency.percentChange.format(f: ".2")
        let formattedPrice = MainViewController.priceFormatter.string(from: NSNumber(value: crypto.quote.currency.price)) ?? ""
        
        // Assign values to cell
        cell.configure(name: crypto.name, change: "\(formattedChange) %", price: "\(formattedPrice)", symbol: crypto.symbol)
        viewModel.setTextColor(label: cell.changeLabel, change: crypto.quote.currency.percentChange)
    }
    
    func setImageLogo(with viewModel: CryptoViewModelProtocol , for cell: CurrencyTableViewCell, indexPath: IndexPath) {
        
       
        // Fetch image and assign to iconImageView
        if(indexPath.row > viewModel.masterData.count-1) {
            return
        } else {
            let crypto = viewModel.masterData[indexPath.row]
            let coinGeckoUrl = crypto.image
            guard let url = URL(string: coinGeckoUrl) else {return}
            cell.iconImage.kf.setImage(with: url)
        }
    }
    
    func getDetailViewData(with viewModel: CryptoViewModelProtocol, for indexPath: IndexPath, with vc: DetailViewController) {
        
        let model = viewModel.cryptoModel.data[indexPath.row]
        
        // Format values
        let formattedMarketCap = MainViewController.priceFormatter.string(from: NSNumber(value: model.quote.currency.marketCap)) ?? ""
        let formattedPrice = MainViewController.priceFormatter.string(from: NSNumber(value: model.quote.currency.price)) ?? ""
        let formattedVolume = MainViewController.volumeFormatter.string(from: NSNumber(value: model.quote.currency.volume)) ?? ""
        let formattedChange = model.quote.currency.percentChange.format(f: ".2")
        
        // Assign values to vc
        vc.marketCapLabel.text = "Market Cap = \(formattedMarketCap)"
        vc.priceLabel.text = "Price = \(formattedPrice)"
        vc.changeLabel.text = "Change = \(formattedChange) %"
        vc.volumeLabel.text = "Volume = \(formattedVolume)"
    }
    
}


