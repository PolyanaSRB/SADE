//
//  ProfileController.swift
//  Monitor
//
//  Created by user174461 on 7/5/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit

// Controller of the user information and logout screen
class ProfileController: UIViewController {
    
    // TODO: let user change his informations
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var career: UILabel!
    @IBOutlet weak var registerNumber: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var password: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hcw = COVID19UsefulData.shared.healthCareWorker
        self.name.text = hcw?.name
        self.email.text = hcw?.email
        self.career.text = "Enfermeira" // TODO: recover if de HealthCareWorker is a Nurse or a Doctor
        self.registerNumber.text = "123456-ENF" // TODO: get the register number from the Doctor or Nurse object
        self.speciality.text = "-" // TODO: if is a Doctor, get the speciality
        self.password.text = "****" // TODO: recover the passwork and write hiden
        
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        //COVID19UsefulData.shared.behavior?.stop()
        Environment.environment.stop()
        self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
    }

}
