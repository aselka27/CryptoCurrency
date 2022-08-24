//
//  TabBarControllerViewController.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 9.08.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - VCs
    private let mainView = UINavigationController(rootViewController: MainViewController())
    private let chartView = UINavigationController(rootViewController: PriceLineChartController())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - ConfigureUI
    private func configureUI() {
        mainView.title = "Crypto"
        chartView.title = "Chart"
        
        assignVCs()
        setImages()
        
        tabBar.tintColor = .black
        tabBar.barTintColor = UIColor(red: 123/255, green: 90/255, blue: 223/255, alpha: 1)
    }
    
    private func assignVCs() {
        setViewControllers([mainView, chartView], animated: true)
    }
    
    private func setImages() {
        guard let items = self.tabBar.items else {return}
        let images = ["dollarsign.circle.fill", "chart.line.uptrend.xyaxis.circle.fill"]
        for i in 0...images.count-1 {
            items[i].image = UIImage(systemName: images[i])
        }
    }
}
