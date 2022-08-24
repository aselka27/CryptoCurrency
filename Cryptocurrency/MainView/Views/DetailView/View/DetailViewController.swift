//
//  DetailViewController.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 6.08.2022.
//

import UIKit
import SnapKit
import Charts

class DetailViewController: UIViewController {
    
    // MARK: - Views
    lazy var marketCapLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = .white
        return label
    } ()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = .white
        return label
    } ()
    
    lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    } ()
    
    lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    } ()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.distribution = .fillProportionally
        return stack
    } ()
    
    // MARK: - Lifecycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure
    private func configureUI() {
        setViews()
        setConstraints()
        view.backgroundColor = UIColor(r: 87, g: 64, b: 196)
    }
    
    private func setViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(marketCapLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(changeLabel)
        stackView.addArrangedSubview(volumeLabel)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.right.equalToSuperview().offset(16)
        }
    }
}
