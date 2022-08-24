//
//  LineChartFormatter.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 24.08.2022.
//


import UIKit
import Foundation
import Charts
//
//@objc(LineChartFormatter)
//public class LineChartFormatter: NSObject, IAxisValueFormatter{
//    
//    var coins: [String]! = ["BTC", "ETH", "USDT", "USDC", "BNB", "BUSD", "XRP", "ADA","SOL","DOGE"]
//    
//    
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return coins[Int(value)]
//    }
//    
//}

extension PriceLineChartController {

     class LineChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
}
