//
//  LoginController.swift
//  Monitor
//
//  Created by user174461 on 7/5/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit

// Controller of the login screen
class LoginController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtLogin: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtLogin.delegate = self
        self.txtPassword.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        print("Entrar")
        
        // Testing if login exists. If so, collects their general information and which patients are being monitored. After that, initializes the agent with cyclic collector behavior to collect new vital signs from database
        // it is just a test, ideally it would call in the database
        if (self.txtLogin.text == "natalie@gmail.com" && self.txtPassword.text == "1234") {
            let hcw = COVID19DAOIdentifyHCW.identifyHCW(email: self.txtLogin.text ?? "")!
            COVID19UsefulData.shared.healthCareWorker = hcw
            
            let patients = COVID19DAOGetPatients.getHCWPatients(hcw: hcw)
            COVID19UsefulData.shared.patients = patients
            for patient in patients {
                COVID19DAOPatientVitalSign.getVitalSign(patient: patient, option: "all")
            }
            
            //let b = CollectorAction(interval: 5)
            //CollectorAgent.addBehavior(behavior: b)
            Environment.environment.start()
            
            performSegue(withIdentifier: "goToMyPatients", sender: self)
        }
        
        else {
            print("Login não efetuado")
            let alert = UIAlertController(title: "Alerta", message: "Erro no Login/Senha", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    // function to register a new user
    @IBAction func signUp(_ sender: Any) {
        print("Cadastrar")
        performSegue(withIdentifier: "goToCreateAccount", sender: self)
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        self.txtLogin.text = ""
        self.txtPassword.text = ""
    }
}
