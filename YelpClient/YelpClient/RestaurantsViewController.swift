//
//  RestaurantsViewController.swift
//  YelpClient
//
//  Created by Mahadevan, Ramesh on 9/22/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
//    let yelpConsumerKey = "gHBS1xPTY9-IqZfrxKHcjA"
//    let yelpConsumerSecret = "9weUSxHsfq5iWl2WV3QRKLC8EWc"
//    let yelpToken = "39kn0Xj1hD1nQxmMLv6vFZMBHUGBmT1b"
//    let yelpTokenSecret = "8e9R-m5llRMxLGaPgjvK_tGvCw4"
    
        let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
        let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
        let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
        let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    //
    var restaurants: [NSDictionary]=[];
    
    @IBOutlet weak var restaurantsList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsList.delegate = self;
        restaurantsList.dataSource = self;
        
        let  apiClient = ApiClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret);
        
        
        apiClient.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.restaurants = (response as NSDictionary)["businesses"] as [NSDictionary];
            self.restaurantsList.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count;
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("titleCard") as RestaurantTitleCard;
        var restaurant = self.restaurants[indexPath.row];
        var thumbnail = restaurant["image_url"] as NSString;

        cell.restaurantTitle.text = restaurant["name"] as NSString
        cell.thumbView.setImageWithURL(NSURL(string:thumbnail));
        cell.reviewStars.setImageWithURL(NSURL(string:restaurant["rating_img_url_small"] as NSString));
        var reviewCount = restaurant["review_count"]
        cell.reviewCount.text = "\(reviewCount) Reviews"
        var location = restaurant["location"] as NSDictionary;
        var address = location["address"] as NSArray
        cell.address.text = address[0] as String;
        return cell;
    }
    
}
