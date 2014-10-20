//
//  ViewController.swift
//  HealthTodo
//
//  Created by Mahadevan, Ramesh on 10/8/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit
import HealthKit
import Foundation

class ViewController: UIViewController{
    let interval = NSDateComponents();
    let healthStore =  HKHealthStore()
    
    /**Variable Declaration of Button Defined in StoryBoard***/
    @IBAction func onPushAction(sender: AnyObject) {
        println("Button Clicked");
    }
    @IBOutlet weak var helloButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        executeSimpleHealthQuery()
    }
    
    func plotData(value: NSObject, forDate: NSDate){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func executeSimpleHealthQuery(){
//        var stepIdentifierType:HKSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
////        var stepQuery = HKSampleQuery(sampleType: stepIdentifierType, predicate: nil, limit: 1,
////            sortDescriptors: nil) { (sampleQuery: HKSampleQuery!, result:[NSObject]!, error: NSError!) -> Void in
////                self.onSampleQueryComplete(result, error: error)
////        }
//        var sampleQuery = HKSampleQuery(sampleType: stepIdentifierType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, result, error) -> Void in
//            println("Retrieve data")
//        }
//        var healthStore = HKHealthStore();
//        healthStore.executeQuery(sampleQuery)
//        
//    }
    
    func onSampleQueryComplete(result: [AnyObject]!, error: NSError!)-> Void{
        
        println("Sample Query for Step Identifier Complete");
        if(error != nil){
            println("Error in retrieving sample query")
        }else{
            if(result != nil){
                println("Successfully fetched sample query")
            }
        }
        
    }
    
    func perfromQueryForWeightSamples() {
        let endDate = NSDate()
        let startDate = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitMonth, value: -2, toDate: endDate, options: nil)
        
        let weightSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
        
        let query = HKSampleQuery(sampleType: weightSampleType, predicate: predicate, limit: 0, sortDescriptors: nil, resultsHandler: {
            (query, results, error) in
            if results == nil {
                println("There was an error running the query: \(error)")
            }
            
            dispatch_async(dispatch_get_main_queue()) {
            }
            
        })
        self.healthStore.executeQuery(query)
//        self.healthStore?.executeQuery(query)
    }
}

