//
//  LoginController.swift
//  Monitor
//
//  Created by user174461 on 7/5/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit
//import SocketSwift
import Foundation
//import SwiftSocket


// Controller of the login screen
class LoginController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtLogin: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtLogin.delegate = self
        self.txtPassword.delegate = self
    

        // Do any additional setup after loading the view.
        //CFSocketCreate(<#T##allocator: CFAllocator!##CFAllocator!#>, <#T##protocolFamily: Int32##Int32#>, <#T##socketType: Int32##Int32#>, <#T##protocol: Int32##Int32#>, <#T##callBackTypes: CFOptionFlags##CFOptionFlags#>, <#T##callout: CFSocketCallBack!##CFSocketCallBack!##(CFSocket?, CFSocketCallBackType, CFData?, UnsafeRawPointer?, UnsafeMutableRawPointer?) -> Void#>, <#T##context: UnsafePointer<CFSocketContext>!##UnsafePointer<CFSocketContext>!#>)
        //CFSocketCreateRunLoopSource(<#T##allocator: CFAllocator!##CFAllocator!#>, <#T##s: CFSocket!##CFSocket!#>, <#T##order: CFIndex##CFIndex#>)
        //CFRunLoopAddSource(<#T##rl: CFRunLoop!##CFRunLoop!#>, <#T##source: CFRunLoopSource!##CFRunLoopSource!#>, <#T##mode: CFRunLoopMode!##CFRunLoopMode!#>)
        //CFSocketSendData(<#T##s: CFSocket!##CFSocket!#>, <#T##address: CFData!##CFData!#>, <#T##data: CFData!##CFData!#>, <#T##timeout: CFTimeInterval##CFTimeInterval#>)
        //Server.run()
        //Client.run()
        /*do {
            let server = try Socket(.inet, type: .stream, protocol: .tcp) // create server socket
            try server.set(option: .reuseAddress, true) // set SO_REUSEADDR to 1
            try server.bind(port: 8090, address: nil) // bind 'localhost:8090' address to the socket
            try server.listen() // allow incoming connections

            let client = try Socket(.inet, type: .stream, protocol: .tcp) // create client socket
            try client.connect(port: 8090) // connect to localhost:8090
            
            

            //let clientAtServerside = try server.accept() // accept client connection
            
            let teste = ([UInt8])("Teste".utf8)
            print("criou client e server")
            try client.write(teste)
            print("escreveu")
            var buffer = [UInt8](repeating: 0, count: teste.count) // allocate buffer
            let numberOfReadBytes = try server.read(&buffer, size: teste.count)
            //try server.accept()
            print(numberOfReadBytes == teste.count)
            //try server.read()
            print("leu")
            //print(numberOfReadBytes == teste.count) // true
            //print(buffer == teste) // true
            print("done")
            
            
            /*let helloBytes = ([UInt8])("Hello World".utf8)
            try clientAtServerside.write(helloBytes) // sending bytes to the client
            clientAtServerside.close()

            var buffer = [UInt8](repeating: 0, count: helloBytes.count) // allocate buffer
            let numberOfReadBytes = try client.read(&buffer, size: helloBytes.count)
            print(numberOfReadBytes == helloBytes.count) // true
            print(buffer == helloBytes) // true
            print("done")*/

            client.close()
            server.close()
        } catch {
            print(error)
        }*/

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
