//
//  DataStore.swift
//  Monitor
//
//  Created by user174461 on 10/6/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

// import Foundation
import HealthKit

class HealthKitReaderWriter {
    // function to get main characteristics
    class func getAgeSexAndBloodType() throws -> (age: Int,
                                                  biologicalSex: HKBiologicalSex,
                                                  bloodType: HKBloodType) {
        
        let healthKitStore = HKHealthStore()
        
        do {

            //1. This method throws an error if these data are not available.
            let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
            let biologicalSex =       try healthKitStore.biologicalSex()
            let bloodType =           try healthKitStore.bloodType()
              
            //2. Use Calendar to calculate age.
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                                from: today)
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!
             
            //3. Unwrap the wrappers to get the underlying enum values.
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
              
            return (age, unwrappedBiologicalSex, unwrappedBloodType)
        }
    }
    
    class func getSample(for sampleType: HKSampleType, startDate: Date, endDate: Date, limit: Int = Int(HKObjectQueryNoLimit),
                                   completion: @escaping ([HKQuantitySample]?, Error?) -> Swift.Void) {
      
        // for the most recent sample, set limit=1, startDate=Date.distantPast and endDate=Date()
        //1. Use HKQuery to load the most recent samples.
        let samplePredicate = HKQuery.predicateForSamples(withStart: startDate,
                                                              end: endDate,
                                                              options: .strictEndDate)
            
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
            
        //let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: samplePredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            //2. Always dispatch to the main thread when complete.
            DispatchQueue.main.async {
                
              guard //let samples = samples,
                    let completeSample = samples as? [HKQuantitySample] else {
                        
                    completion(nil, error)
                    return
              }
                
              completion(completeSample, nil)
            }
          }
     
        HKHealthStore().execute(sampleQuery)
    }
    
    class func saveQuantitySample(type: HKQuantityType, quantity: HKQuantity, date: Date) {
        let quantitySample = HKQuantitySample(type: type,
                                              quantity: quantity,
                                              start: date,
                                              end: date)

        HKHealthStore().save(quantitySample) { (success, error) in
            if let error = error {
                print("Error Saving Quantity Sample: \(error.localizedDescription)")
            } else {
                print("Successfully saved Quantity Sample")
            }
        }
    }
    
    class func saveCategorySample(type: HKCategoryType, value: Int, date: Date) {
        // this fuction can be used by healthcare worker to insert patient symptoms
        let categorySample = HKCategorySample(type: type,
                                              value: value,
                                              start: date,
                                              end: date)
        
        HKHealthStore().save(categorySample) { (success, error) in
            if let error = error {
                print("Error Saving Category Sample: \(error.localizedDescription)")
            } else {
                print("Successfully saved Category Sample")
            }
        }
    }
    
    class func saveCorrelation(type: HKCorrelationType, objects: Set<HKSample>, date: Date) {
        let correlationSample = HKCorrelation(type: type,
                                              start: date,
                                              end: date,
                                              objects: objects)
        
        HKHealthStore().save(correlationSample) { (success, error) in
            if let error = error {
                print("Error Saving Correlation: \(error.localizedDescription)")
            } else {
                print("Successfully saved Correlation")
            }
        }
    }
}
