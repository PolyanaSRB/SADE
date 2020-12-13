//
//  COVID19DAOGetPatients.swift
//  Monitor
//
//  Created by user174461 on 7/12/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// DAO to access database and identify patients already monitored by the healthcare worker after the login
class COVID19DAOGetPatients {
    static func getHCWPatients(hcw: HealthCareWorker) -> [COVID19Patient] {
        // supose we connected to database and found the HCW and collect his patients' infos
        // now, let's create a Patient objects for each one and save them inside HCW object
        
        var patients: [COVID19Patient] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        patients.append(COVID19Patient.init(name: "Ana Carolina", cpf: "123.456.789-10", phone: "(21)99999-9999", dateBirth: dateFormatter.date(from: "01-01-1950")!, comorbidity: "Diabetes", allergy: "Lactose; Sulfa", dateEntrance: dateFormatter.date(from: "01-04-2020")!, isMonitored: true, breath: true)) //, hospitalSector: ""))
        
        patients.append(COVID19Patient.init(name: "Lucas Silva", cpf: "109.876.543-21", phone: "(21)88888-8888", dateBirth: dateFormatter.date(from: "23-06-1989")!, comorbidity: "", allergy: "Glúten", dateEntrance: dateFormatter.date(from: "10-06-2020")!, isMonitored: true, breath: false)) //, hospitalSector: ""))
        
        patients.append(COVID19Patient.init(name: "Rosângela Pariz", cpf: "029.374.445-09", phone: "(21)77777-7777", dateBirth: dateFormatter.date(from: "10-12-1970")!, comorbidity: "Hipertensão", allergy: "Dipirona", dateEntrance: dateFormatter.date(from: "07-07-2020")!, isMonitored: true, breath: true)) //, hospitalSector: ""))
        
        // TODO: get the HospitalSector, chack if there is already the object HospitalSector associated with de hospital of patient and add it to the initializer
        // TODO: search for patients of the registered hospital too and save it with isMonitored = false

        return patients
    }
}
