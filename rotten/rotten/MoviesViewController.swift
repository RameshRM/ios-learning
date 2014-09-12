//
//  MoviesViewController.swift
//  rotten
//
//  Created by Mahadevan, Ramesh on 9/10/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var moviesList: UITableView!
    var movies: [NSDictionary]=[];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesList.delegate = self;
        moviesList.dataSource = self;
        var url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=pxjybvsv8vv9e3h5bfn8ejmc&q=disney&page_limit=30";
        var request = NSURLRequest(URL: NSURL(string: url));
        NSURLConnection.sendAsynchronousRequest(request,queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var moviesResult = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
            self.movies = moviesResult["movies"] as [NSDictionary];
            self.moviesList.reloadData()
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.movies.count
        ;
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        var movieCard = moviesList.dequeueReusableCellWithIdentifier("movieCard") as MovieCardTableViewCell;
        var movieEntity = self.movies[indexPath.row];
        
        movieCard.movieTitle.text = movieEntity["title"] as? String;
        movieCard.movieSynopsis.text = movieEntity["synopsis"] as? String;
        var posters = movieEntity["posters"] as NSDictionary;
        var posterUrl = posters["profile"] as? String;
        movieCard.moviePoster.setImageWithURL(NSURL(string: posterUrl));
        return movieCard;
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
