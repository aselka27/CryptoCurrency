//
//  ViewController.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 5.08.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Property
    var viewModel: CryptoViewModelProtocol
    
    // MARK: - Views
    let tableView: UITableView = {
        let table = UITableView()
        table.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        return table
    } ()
    
    // MARK: - Init
    init(viewModel: CryptoViewModelProtocol = CryptoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getCrypto()
        
        viewModel.callBack = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - ConfigureUI
    private func configureUI() {
        setViews()
        setConstraints()
        configureTableView()
        view.backgroundColor = .white
        title = "Crypto"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setViews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        tableView.backgroundColor = UIColor(r: 123, g: 90, b: 223)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .black
        tableView.separatorStyle = .singleLine
    }
    
    // MARK: - Get crypto data
    private func getCrypto() {
        viewModel.getData()
        viewModel.getCoinLogos()
    }
}

    // MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cryptoModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
        
        getCellData(with: viewModel, for: indexPath, cell: cell)
        setImageLogo(with: viewModel, for: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailViewController()
        getDetailViewData(with: viewModel, for: indexPath,  with: controller)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {
    
}




