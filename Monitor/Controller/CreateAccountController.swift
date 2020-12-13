//
//  ViewController2.swift
//  Monitor
//
//  Created by Andrew Costa on 22/04/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit

// Controller of the register screen
class CreateAccountController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var hospitals:[String] = ["São José", "Barra Dor", "São Lucas", "Vitória", "Lourenço Jorge"] // TODO: get hospitals from DataBase
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hospitals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = hospitals[row]

        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: 17.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])

        return myTitle

    }
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtHospital: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtHospital.delegate = self
        self.txtHospital.dataSource = self
        self.txtName.delegate = self
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        self.txtConfirmPassword.delegate = self
        print("Entrou na tela 2!!")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func register(_ sender: Any) {
        // TODO: register new user into DataBase
        
        //var selectedValue = txtHospital[pickerView.selectedRowInComponent(0)]
    }
}
