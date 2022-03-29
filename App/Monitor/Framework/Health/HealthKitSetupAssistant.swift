//
//  HealthKitSetupAssistant.swift
//  Monitor
//
//  Created by user174461 on 10/6/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

// import Foundation
import HealthKit
// hotspot
// template method - passo a passo de execucao
class HealthKitSetupAssistant {
  
    var healthKitTypesToRead: Set<HKObjectType> = []
    var healthKitTypesToWrite: Set<HKSampleType> = []
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
  
    func createHKType() -> Bool {
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
                let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
                let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
                let allergy = HKObjectType.clinicalType(forIdentifier: .allergyRecord),
                let comorbidity = HKObjectType.clinicalType(forIdentifier: .conditionRecord),
                let spo2 = HKObjectType.quantityType(forIdentifier: .oxygenSaturation),
                //let spo22 = HKSampleType.quantityType(forIdentifier: .oxygenSaturation),
                let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
                let temperature = HKObjectType.quantityType(forIdentifier: .bodyTemperature),
                let pas = HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic),
                let pad = HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic),
                //let ecg = HKObjectType.electrocardiogramType(),
                let breathRate = HKObjectType.quantityType(forIdentifier: .respiratoryRate)
        
        else {
                
                // completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return false
        }
        self.healthKitTypesToRead = [dateOfBirth, bloodType, biologicalSex, allergy, comorbidity, spo2, heartRate, temperature, pas, pad, breathRate]
        self.healthKitTypesToWrite = [spo2, heartRate, temperature, pas, pad, breathRate]
        return true
    }
    
    final func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        //1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
          completion(false, HealthkitSetupError.notAvailableOnDevice)
          return
        }
        //2. Prepare the data types that will interact with HealthKit
        guard createHKType() else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }

        //3. Request Authorization
        HKHealthStore().requestAuthorization(toShare: self.healthKitTypesToWrite,
                                             read: self.healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
}
