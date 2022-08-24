//
//  CurrencyTableViewCell.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 5.08.2022.
//

import UIKit
import SnapKit

class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: - Property
    static let identifier = "CurrencyCell"
    // MARK: - Views
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.sizeToFit()
        return label
    } ()
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.sizeToFit()
        label.textAlignment = .left
        return label
    } ()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.sizeToFit()
        label.textColor = .white
        label.textAlignment = .right
        return label
    } ()
    
    lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.sizeToFit()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .white
        label.textAlignment = .right
        return label
    } ()
    
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        return image
    } ()

    // MARK: - Lifecycle VC
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       // configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
   
    // MARK: - Congigure
    
    private func configureUI() {
        backgroundColor = UIColor(r: 87, g: 64, b: 196, alpha: 0.8)
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(changeLabel)
        contentView.addSubview(iconImage)
        contentView.addSubview(symbolLabel)
        
    }
    
    private func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.leading.equalTo(iconImage.snp.trailing).offset(20)
        }
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(contentView).inset(20)
        }
        changeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel).inset(25)
            make.right.equalTo(contentView).inset(20)
        }
        iconImage.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.top.equalTo(contentView).inset(5)
            make.left.equalTo(contentView).inset(5)
        }
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(iconImage.snp.trailing).offset(20)
        }
    }
    
    // MARK: - Prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        changeLabel.text = nil
        symbolLabel.text = nil
        iconImage.image = nil
    }
    
    // MARK: - Helpers
    func configure(name: String, change: String, price: String, symbol: String) {
        nameLabel.text = name
        priceLabel.text = price
        changeLabel.text = change
        symbolLabel.text = symbol
    }
}

