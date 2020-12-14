//
//  PatientInfosController.swift
//  Monitor
//
//  Created by user174461 on 7/5/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit

// Controller of the patient general information screen
class PatientInfosController: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cpf: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var birth: UILabel!
    @IBOutlet weak var comorbity: UILabel!
    @IBOutlet weak var allergy: UILabel!
    @IBOutlet weak var hospitalSector: UILabel!
    @IBOutlet weak var dateEntrance: UILabel!
    @IBOutlet weak var breather: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let patientMonitor = TabBarControllerViewController.patientSelected
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        self.name.text = patientMonitor?.name
        self.cpf.text = patientMonitor?.cpf
        self.phone.text = patientMonitor?.phone
        self.birth.text = dateFormatter.string(from: patientMonitor!.dateBirth)
        self.comorbity.text = patientMonitor?.comorbidity
        self.allergy.text = patientMonitor?.allergy
        self.hospitalSector.text = patientMonitor?.hospitalSector?.name
        self.dateEntrance.text = dateFormatter.string(from: patientMonitor!.dateEntrance)
        self.breather.text = String(patientMonitor?.breath ?? false)
        
        
    }
}
