//
//  COVID19DAOOdentifyHospital.swift
//  Monitor
//
//  Created by user174461 on 7/12/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// DAO to access database and identify the healthcare worker hospital after the login, in order to identify patients that the user can monitor
class COVID19DAOIdentifyHospital {
    static func identifyHospital(name: String) -> Hospital {
        // supose we connected to database and found the hospital with the name passed like parameter
        let hospital = Hospital.init(name: name, address: "Rua Sei la o que, 1")
        // TODO: get hospital sectors and save it as an object and inside the var of Hospital
        return hospital
        
    }
}
