//
//  ViewController.swift
//  TweetClient
//
//  Created by Mahadevan, Ramesh on 9/28/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterOAuthClient.instance.onAuthCompleted { (user: NSObject?, error: NSError?) -> Void in
            if(user != nil){
                
            }
        }
 
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

