//
//  HealthKitSetupAssistant.swift
//  Monitor
//
//  Created by user174461 on 10/6/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

// import Foundation
import HealthKit

/// Class that offers functions to request authorization to read and write health data
///
/// However, two steps are necessary before calling these functions:
///
/// 1. adding HealthKit as a capability in a development project;
/// 2. describing why you need access to health data keys in the “Privacy – Health Share Usage Description” and “Privacy – Health Update Usage Description” of the Info.plist file.
class HealthKitSetupAssistant {
  
    /// health data desired to read from HealthKit
    var healthKitTypesToRead: Set<HKObjectType> = []
    /// health data desired to write into HealthKit
    var healthKitTypesToWrite: Set<HKSampleType> = []
    
    /// possible errors
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
  
    /// Prepares the desired data types to interact with
    func createHKType() -> Bool {
        guard   let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
                let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
                let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
                let allergy = HKObjectType.clinicalType(forIdentifier: .allergyRecord),
                let comorbidity = HKObjectType.clinicalType(forIdentifier: .conditionRecord),
                let spo2 = HKObjectType.quantityType(forIdentifier: .oxygenSaturation),
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
    
    /// Checks if HealthKit is available, prepares the desired data types, and requests for authorization to access all desired data types
    final func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        /// 1. Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
          completion(false, HealthkitSetupError.notAvailableOnDevice)
          return
        }
        /// 2. Prepare the data types that will interact with HealthKit
        guard createHKType() else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }

        /// 3. Request Authorization
        HKHealthStore().requestAuthorization(toShare: self.healthKitTypesToWrite,
                                             read: self.healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
    
}
