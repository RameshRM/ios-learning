//
//  ViewController.swift
//  HealthTodo
//
//  Created by Mahadevan, Ramesh on 10/8/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit
import HealthKit


class ViewController: UIViewController{
    let interval = NSDateComponents();
    
    /**Variable Declaration of Button Defined in StoryBoard***/
    @IBAction func onPushAction(sender: AnyObject) {
        println("Button Clicked");
    }
    @IBOutlet weak var helloButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        executeSimpleHealthQuery()
    }
    
    func plotData(value: NSObject, forDate: NSDate){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func executeSimpleHealthQuery(){
        var stepIdentifierType:HKSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        var stepQuery = HKSampleQuery(sampleType: stepIdentifierType, predicate: nil, limit: 1,
            sortDescriptors: nil) { (sampleQuery: HKSampleQuery!, result:[AnyObject]!, error: NSError!) -> Void in
                self.onSampleQueryComplete(result, error: error)
        }
        var healthStore = HKHealthStore();
        healthStore.executeQuery(stepQuery)
        
    }
    
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
}

