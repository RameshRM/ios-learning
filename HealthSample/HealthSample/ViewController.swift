//
//  ViewController.swift
//  HealthSample
//
//  Created by Mahadevan, Ramesh on 10/19/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController, HealthStoreUser {

    @IBOutlet weak var onChange: UIButton!
    var healthStore: HKHealthStore?
    let massFormatter = NSMassFormatter()
    @IBOutlet weak var weight: UILabel!
    /**
    ** Init
    **/
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createAndPropagateHealthStore()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        createAndPropagateHealthStore()
    }
  
    
    private func createAndPropagateHealthStore() {
        if self.healthStore == nil {
            self.healthStore = HKHealthStore()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorisationForHealthStore()
        getWeightInKg();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    


    private func requestAuthorisationForHealthStore() {
        let dataTypesToWrite = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        ]
        let dataTypesToRead = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex),
            HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)
        ]
        
        self.healthStore?.requestAuthorizationToShareTypes(NSSet(array: dataTypesToWrite),
            readTypes: NSSet(array: dataTypesToRead), completion: {
                (success, error) in
                if success {
                } else {
                    println("The user cancelled the authorisation request. \(error)")
                }
        })
    }
    
    func getWeightInKg(){
        var stepIdentifierType:HKSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        var stepQuery = HKSampleQuery(sampleType: stepIdentifierType, predicate: nil, limit: 1,
            sortDescriptors: nil) { (sampleQuery: HKSampleQuery!, result:[AnyObject]!, error: NSError!) -> Void in
                self.onSampleQueryComplete(result, error: error)
        }
        var healthStore = HKHealthStore();
        healthStore.executeQuery(stepQuery)
        var heightSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
        let updateHandler: (HKObserverQuery!, HKObserverQueryCompletionHandler!, NSError!) -> Void = { query, completion, error in
            self.sendNotification()
        }
        
        var observeHeightChange = HKObserverQuery(sampleType: heightSampleType, predicate: nil, updateHandler: updateHandler)
        healthStore.executeQuery(observeHeightChange);
    }

    func onSampleQueryComplete(result: [AnyObject]!, error: NSError!)-> Void{
        if(error != nil){
            println("Error in retrieving sample query")
        }else{
            if(result != nil){
                var weight = result[0] as HKQuantitySample
                let weightReturned = weight.quantity.doubleValueForUnit(HKUnit(fromString: "kg"))
                self.weight?.text = "\(massFormatter.stringFromValue(weightReturned, unit:.Kilogram))"
            }
        }
        
        
    }
    
    @IBAction func onChange(sender: AnyObject) {
        let weightType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        
        let weightValue = HKQuantity(unit: HKUnit(fromString: "kg"), doubleValue: 35)
        
        let metadata = [ HKMetadataKeyWasUserEntered : true ]
        
//        let sample = HKQuantitySample(type: weightType,
//            quantity: <#HKQuantity!#>,
//            startDate: <#NSDate!#>,
//            endDate: <#NSDate!#>)
//        
    }
    
    
    func sendNotification() -> Void{
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Observing Height Change"
        localNotification.alertBody = "Height is changed from HealthData"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

    }

}

