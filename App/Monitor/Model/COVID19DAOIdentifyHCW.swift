//
//  COVID19DAOIdentifyHCW.swift
//  Monitor
//
//  Created by user174461 on 7/12/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// DAO to access database and collect healthcare worker register information after the login
class COVID19DAOIdentifyHCW {
    static func identifyHCW(email: String) -> HealthCareWorker?  {
        // 1) connect to database and search for health care worker there and save it as a HealthCareWorker object
        // 2) supose that the HCW is referenced to the email natalie@gmail.com and we went there to the database to get infos. Let's save the infos to the object HealthCareWorker just to make a simulation
        let password = "1234"
        let name = "Natalie Barboza"
        let hospitalName = "São José"
        let corem = "123456-ENF"
        let hospital = COVID19DAOIdentifyHospital.identifyHospital(name: hospitalName)
        COVID19UsefulData.shared.hospital = hospital
        let hcw = Nurse.init(email: email, password: password, name: name, hospital: hospital, corem: corem)
        
        return hcw
    }
}
