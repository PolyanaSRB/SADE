//
//  MonitorViewController.swift
//  Monitor
//
//  Created by Andrew Costa on 15/05/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit
import Charts

// Controller of the monitor screen, showing the vital signs of a patient graphically
class MonitorController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lineChart1: LineChartView!
    @IBOutlet weak var lineChart2: LineChartView!
    @IBOutlet weak var linchart3: LineChartView!
    @IBOutlet weak var bpm: UILabel!
    @IBOutlet weak var spo2_number: UILabel!
    @IBOutlet weak var rpm_number: UILabel!
    @IBOutlet weak var temp_number: UILabel!
    @IBOutlet weak var pa_number: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lineChart1.animate(xAxisDuration: 1.0, easingOption: .linear)
        lineChart2.animate(xAxisDuration: 1.0, easingOption: .linear)
        linchart3.animate(xAxisDuration: 1.0, yAxisDuration:1.0, easingOption: .linear)
        
        COVID19CollectorBehavior.monitorController = self
        
        let patientMonitor = TabBarControllerViewController.patientSelected
        self.name.text = patientMonitor?.name
        
        let aux = patientMonitor?.vitalSign[COVID19UsefulData.shared.ecg.name]?.count ?? 1
        let dp = Array(1...aux)
        let str_dp = dp.map { String($0) }

        setChart(dataPoints: str_dp, values: patientMonitor?.getVitalSignPatient(type: COVID19UsefulData.shared.ecg) ?? [], lineChart: lineChart1)
        setChartCubi(dataPoints: str_dp, values: patientMonitor?.getVitalSignPatient(type: COVID19UsefulData.shared.spo2) ?? [], lineChart: lineChart2)
        setChartCubi(dataPoints: str_dp, values: patientMonitor?.getVitalSignPatient(type: COVID19UsefulData.shared.fr) ?? [], lineChart: linchart3)
        
    }
    
    func setChart(dataPoints: [String], values: [Double], lineChart:LineChartView) {
        
          var dataEntries: [ChartDataEntry] = []

          for i in 0..<dataPoints.count {
              let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
              dataEntries.append(dataEntry)
          }

          let chartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
          chartDataSet.circleRadius = 2
          chartDataSet.circleHoleRadius = 2
          chartDataSet.drawValuesEnabled = false
          

          let chartData = LineChartData(dataSets: [chartDataSet])

          lineChart.data = chartData
          lineChart.setVisibleXRangeMaximum(10)
          lineChart.moveViewToX(Double(values.count))
          lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
          lineChart.xAxis.setLabelCount(dataPoints.count, force: true)
          lineChart.xAxis.labelPosition = .bottom
          lineChart.xAxis.drawGridLinesEnabled = false
          lineChart.xAxis.avoidFirstLastClippingEnabled = true

          lineChart.rightAxis.drawAxisLineEnabled = false
          lineChart.rightAxis.drawLabelsEnabled = false

          lineChart.leftAxis.drawAxisLineEnabled = false
          lineChart.pinchZoomEnabled = false
          lineChart.doubleTapToZoomEnabled = false
          lineChart.legend.enabled = false
       
          lineChart.backgroundColor = .black
          lineChart.xAxis.labelTextColor = .white
          lineChart.leftAxis.labelTextColor = .white
          lineChart.rightAxis.labelTextColor = .white
       
      }
    
    func setChartCubi(dataPoints: [String], values: [Double], lineChart:LineChartView) {
        var dataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }

        let chartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.circleRadius = 2
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.circleRadius = 2.0
        
        let chartData = LineChartData(dataSets: [chartDataSet])

        lineChart.data = chartData
        lineChart.setVisibleXRangeMaximum(10)
        lineChart.moveViewToX(Double(values.count))
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChart.xAxis.setLabelCount(dataPoints.count, force: true)
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawLabelsEnabled = false
        
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawLabelsEnabled = false

        lineChart.leftAxis.drawAxisLineEnabled = false
        lineChart.legend.enabled = false
     
        lineChart.backgroundColor = .black
        lineChart.xAxis.labelTextColor = .white
        lineChart.leftAxis.labelTextColor = .white
        lineChart.rightAxis.labelTextColor = .white
        lineChart.rightAxis.enabled = false
     
    }

}
