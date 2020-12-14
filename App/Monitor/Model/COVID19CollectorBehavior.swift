//
//  COVID19CyclicCollectorBehavior.swift
//  Monitor
//
//  Created by user174461 on 7/2/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation
import Charts

// My instance class for collector behavior, inheriting from the Framework class CyclicCollectorBehavior
class COVID19CollectorBehavior : CyclicCollectorBehavior {
    static var monitorController: MonitorController?
    
    // Function to collect new vital signs for each patient being monitored by health care worker logged in the app and to update monitor charts, adding new entries
    @objc override func collect() {
        print("COVID19collector")
        
        for patient in COVID19UsefulData.shared.patients {
            COVID19DAOPatientVitalSign.getVitalSign(patient: patient, option: "last")
        }
   
        if (COVID19CollectorBehavior.monitorController != nil) {
            let patientMonitor = TabBarControllerViewController.patientSelected
            let ecg = patientMonitor?.vitalSign[COVID19UsefulData.shared.ecg.name]?.last?.value
            let spo2 = patientMonitor?.vitalSign[COVID19UsefulData.shared.spo2.name]?.last?.value
            let fr = patientMonitor?.vitalSign[COVID19UsefulData.shared.fr.name]?.last?.value
            let pas = patientMonitor?.vitalSign[COVID19UsefulData.shared.pas.name]?.last?.value
            let pad = patientMonitor?.vitalSign[COVID19UsefulData.shared.pad.name]?.last?.value
            let temp = patientMonitor?.vitalSign[COVID19UsefulData.shared.temp.name]?.last?.value
            
            COVID19CollectorBehavior.monitorController?.pa_number.text = String(Int(pas ?? 0)) + "/" + String(Int(pad ?? 0)) // + "(" + String((pas+pad)/2) + ")"
            COVID19CollectorBehavior.monitorController?.temp_number.text = String(Float(temp ?? 0))
            COVID19CollectorBehavior.monitorController?.bpm.text = String(Int(ecg ?? 0))
            COVID19CollectorBehavior.monitorController?.spo2_number.text = String(Int(spo2 ?? 0))
            COVID19CollectorBehavior.monitorController?.rpm_number.text = String(Int(fr ?? 0))
            
            let pointsCount = patientMonitor?.vitalSign[COVID19UsefulData.shared.ecg.name]?.count
            
            COVID19CollectorBehavior.monitorController?.lineChart1.data?.addEntry(ChartDataEntry(x: Double(pointsCount ?? 0), y: ecg ?? Double(0), data: String(pointsCount ?? 0) as AnyObject), dataSetIndex: 0)
            COVID19CollectorBehavior.monitorController?.lineChart2.data?.addEntry(ChartDataEntry(x: Double(pointsCount ?? 0), y: spo2 ?? Double(0), data: String(pointsCount ?? 0) as AnyObject), dataSetIndex: 0)
            COVID19CollectorBehavior.monitorController?.linchart3.data?.addEntry(ChartDataEntry(x: Double(pointsCount ?? 0), y: fr ?? Double(0), data: String(pointsCount ?? 0) as AnyObject), dataSetIndex: 0)
            
            COVID19CollectorBehavior.monitorController?.lineChart1.notifyDataSetChanged()
            COVID19CollectorBehavior.monitorController?.lineChart1.setVisibleXRangeMaximum(10)
            COVID19CollectorBehavior.monitorController?.lineChart1.moveViewToX(Double((pointsCount ?? 0)))
            
            COVID19CollectorBehavior.monitorController?.lineChart2.notifyDataSetChanged()
            COVID19CollectorBehavior.monitorController?.lineChart2.setVisibleXRangeMaximum(10)
            COVID19CollectorBehavior.monitorController?.lineChart2.moveViewToX(Double((pointsCount ?? 0)))
            
            COVID19CollectorBehavior.monitorController?.linchart3.notifyDataSetChanged()
            COVID19CollectorBehavior.monitorController?.linchart3.setVisibleXRangeMaximum(10)
            COVID19CollectorBehavior.monitorController?.linchart3.moveViewToX(Double((pointsCount ?? 0)))
        }
    }
}
