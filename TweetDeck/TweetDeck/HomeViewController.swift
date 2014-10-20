//
//  HomeViewController.swift
//  TweetDeck
//
//  Created by Mahadevan, Ramesh on 10/5/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func authorize(sender: AnyObject) {
        println("Authorized ..");
        
        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on iOS8"
        localNotification.alertBody = "Woww not it works!!"

        localNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        println("Testing local notification");
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on iOS8"
        localNotification.alertBody = "View Did Load ... Woww it works!!"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
        

        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
