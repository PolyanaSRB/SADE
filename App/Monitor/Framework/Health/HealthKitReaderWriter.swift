//
//  DataStore.swift
//  Monitor
//
//  Created by user174461 on 10/6/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

// import Foundation
import HealthKit

/// Class that offers functions to query health data and save new health data in HealthKit.
class HealthKitReaderWriter {
    
    /// Gets user main characteristics - age, biological sex and blood type.
    class func getAgeSexAndBloodType() throws -> (age: Int,
                                                  biologicalSex: HKBiologicalSex,
                                                  bloodType: HKBloodType) {
        
        let healthKitStore = HKHealthStore()
        
        do {

            /// 1. This method throws an error if these data are not available.
            let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
            let biologicalSex =       try healthKitStore.biologicalSex()
            let bloodType =           try healthKitStore.bloodType()
              
            /// 2. Use Calendar to calculate age.
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                                from: today)
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!
             
            /// 3. Unwrap the wrappers to get the underlying enum values.
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType
              
            return (age, unwrappedBiologicalSex, unwrappedBloodType)
        }
    }
    
    /// Gets data of a sample type between start date and end date
    /// - parameter sampleType: the health data type to collect a sample
    /// - parameter startDate: initial date of the query time range
    /// - parameter endDate: final date of the query time range
    /// - parameter limit: number of results that must be returned
    ///
    /// For the most recent sample, set limit=1, startDate=Date.distantPast and endDate=Date()
    class func getSample(for sampleType: HKSampleType, startDate: Date, endDate: Date, limit: Int = Int(HKObjectQueryNoLimit),
                                   completion: @escaping ([HKQuantitySample]?, Error?) -> Swift.Void) {
      
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
    
    /// Inserts a quantity type into HealthKit
    /// - parameter type: quantity type
    /// - parameter quantity: value of the quantity type data
    /// - parameter date: date of the record
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
    
    /// Inserts a category type into HealthKit
    /// - parameter type: category type
    /// - parameter value: value of the category type data
    /// - parameter date: date of the record
    ///
    /// This fuction can be used by healthcare worker to insert patient symptoms
    class func saveCategorySample(type: HKCategoryType, value: Int, date: Date) {
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
    
    /// Saves a correlation type into HealthKit
    /// - parameter type: correlation type
    /// - parameter objects: set of correlated samples
    /// - parameter date: date of the record
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
