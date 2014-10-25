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
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
        var configList: NSDictionary?
        configList = NSDictionary(contentsOfFile: path!);

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
            self.getHeight()
        }
        var observeHeightChange = HKObserverQuery(sampleType: heightSampleType, predicate: nil, updateHandler: updateHandler)
        healthStore.executeQuery(observeHeightChange);
    }

    func onSampleQueryComplete(result: [AnyObject]!, error: NSError!)-> Void{
        if(error != nil){
            println("Error in retrieving sample query")
        }else{
            if(result != nil){
//                var weight = result[0] as HKQuantitySample
//                let weightReturned = weight.quantity.doubleValueForUnit(HKUnit(fromString: "kg"))
//                self.weight?.text = "\(massFormatter.stringFromValue(weightReturned, unit:.Kilogram))"
            }
        }
        
        
    }
    
    @IBAction func onChange(sender: AnyObject) {
        let weightType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        let weightValue = HKQuantity(unit: HKUnit(fromString: "kg"), doubleValue: 35)
        let metadata = [ HKMetadataKeyWasUserEntered : true ]
    }
    
    
    func sendNotification(notificationMessage: NSString) -> Void{
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Observing Height Change"
        localNotification.alertBody = notificationMessage
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//                callback();
    }

    func getHeight(){
        var height = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
        var sampleHeight = HKSampleQuery(sampleType: height, predicate: nil, limit: 1,
            sortDescriptors: nil) { (sampleQuery: HKSampleQuery!, result:[AnyObject]!, error: NSError!) -> Void in
                self.onHeightSampleReceived(result, error: error)
        }
        var healthStore = HKHealthStore();
        healthStore.executeQuery(sampleHeight)
        
    }
    
    func onHeightSampleReceived(result: [AnyObject]!, error: NSError!)-> Void{
        if(result != nil){
//            var height = result[0] as HKQuantitySample
//            
//            let heightReturned = height.quantity.doubleValueForUnit(HKUnit(fromString: "in"))
//            sendNotification("\(heightReturned)");
        }
        
    }
}

