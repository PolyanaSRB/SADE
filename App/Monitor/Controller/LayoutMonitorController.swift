//
//  LayoutMonitorController.swift
//  Monitor
//
//  Created by user174461 on 7/5/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit

// Controller of the monitor set up screen
class LayoutMonitorController: UIViewController {

    // TODO: when the user leaves this page, save the actual configuration to the monitor layout of the selected patient
    
    @IBOutlet weak var spo2: UISwitch!
    @IBOutlet weak var temperature: UISwitch!
    @IBOutlet weak var pressure: UISwitch!
    @IBOutlet weak var heartRate: UISwitch!
    @IBOutlet weak var ecg: UISwitch!
    @IBOutlet weak var etco2: UISwitch!
    @IBOutlet weak var breath: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
