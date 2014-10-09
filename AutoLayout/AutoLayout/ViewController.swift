//
//  ViewController.swift
//  AutoLayout
//
//  Created by Mahadevan, Ramesh on 9/26/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var thumbImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        thumbImage.image = UIImage(named: "IMG_0165.jpg");
        println(thumbImage);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

