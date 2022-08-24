//
//  PriceLineChartController.swift
//  Cryptocurrency
//
//  Created by саргашкаева on 23.08.2022.
//

import UIKit
import Charts

class PriceLineChartController: UIViewController {
    
    
    // MARK: - Properties
    var entries = [ChartDataEntry]()
    var viewModel: ChartViewModelProtocol
    let xaxis: XAxis = XAxis()
    var priceChange: [Double] = []
    var coins: [String] = []
    
    // MARK: - Init
    init(viewModel: ChartViewModelProtocol=ChartViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor(r: 123, g: 90, b: 223)
        chartView.drawGridBackgroundEnabled = false
        chartView.rightAxis.enabled = false
        return chartView
    } ()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 123, g: 90, b: 223)
        title = "Track Crypto"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureChart()
        customizeAxis()
        getData()
        
        self.viewModel.callBack = { [weak self] data in
            self?.dataForChart(data: data)
        }
    }
    
    // MARK: - Configure chart
    private func configureChart() {
        view.addSubview(lineChartView)
        lineChartView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.right.left.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    // MARK: - Get data for chart
    private func dataForChart(data: CryptoData) {
        
        
        for i in 0..<viewModel.cryptoModel.data.count{
            priceChange.append(Double(viewModel.cryptoModel.data[i].quote.currency.percentChange))
            coins.append(viewModel.cryptoModel.data[i].symbol)
        }
        
        setLineChartData(xValues: coins, yValues: priceChange, label: "Percent Change")
    }
    
    private func getData() {
        viewModel.getData()
    }
    
    private func customizeAxis() {
        let yAxis = lineChartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(10, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(10, force: false)
        xAxis.labelTextColor = .black
        xAxis.axisLineColor = .white
        xAxis.valueFormatter = xaxis.valueFormatter
        
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.animate(xAxisDuration: 2.5)
    }
    
    private func setLineChartData(xValues: [String], yValues: [Double], label: String) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: label)
        let chartData = LineChartData(dataSet: chartDataSet)
        
        let chartFormatter = LineChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        lineChartView.xAxis.valueFormatter = xAxis.valueFormatter
        lineChartView.data = chartData
        
        /// Format data set
        chartDataSet.drawCirclesEnabled = false
        chartData.setDrawValues(false)
        chartDataSet.mode = .cubicBezier
        chartDataSet.lineWidth = 3
        chartDataSet.setColor(.black)
        
        chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
    }
}
