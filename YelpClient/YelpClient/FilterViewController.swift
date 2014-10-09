//
//  FilterViewController.swift
//  YelpClient
//
//  Created by Mahadevan, Ramesh on 9/26/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var generalFeatureList: UITableView!
    @IBOutlet weak var popularFilters: UITableView!
    var popularFilterOptions:Array<NSDictionary>=[];
    var generalFeatures:Array<NSDictionary>=[];

    override func viewDidLoad() {
        super.viewDidLoad()
        var option:NSDictionary=["text":"Open Now", "isSelected": false];
        popularFilterOptions.append(option);
        option=["text":"Hot & New", "isSelected": false];
        self.popularFilterOptions.append(option);
        option=["text":"Offering a Deal", "isSelected": false];
        self.popularFilterOptions.append(option);

        
        popularFilters.delegate = self;
        popularFilters.dataSource = self;
        popularFilters.reloadData();
        
        option=["text":"Take-Out", "isSelected": false];
        
println(self.popularFilterOptions);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println(tableView);
        
        return self.popularFilterOptions.count;
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = popularFilters.dequeueReusableCellWithIdentifier("popularOptions")
            as FilterOptionsTableViewCell
        
        var filterOption = popularFilterOptions[indexPath.row];
        cell.filterOptionText.text = filterOption["text"] as NSString;
        
        var isOn = filterOption["isSelected"] as Bool;
        cell.isFilterOn.on = isOn;
        return cell;
    }
}
