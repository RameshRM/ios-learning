//
//  MoviesViewController.swift
//  rotten
//
//  Created by Mahadevan, Ramesh on 9/10/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet weak var searchFilter: UISearchBar!
    @IBOutlet var moviesView: UIView!
    @IBOutlet weak var moviesList: UITableView!
    var movies: [NSDictionary]=[];
    var busyIndicator = BusyIndicator();
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        moviesList.delegate = self;
        moviesList.dataSource = self;
        self.busyIndicator.busy(moviesView);
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=pxjybvsv8vv9e3h5bfn8ejmc&limit=20";
        var request = NSURLRequest(URL: NSURL(string: url));
        NSURLConnection.sendAsynchronousRequest(request,queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var moviesResult = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
            self.movies = moviesResult["movies"] as [NSDictionary];
            self.moviesList.reloadData()
            self.busyIndicator.free();
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
        var rating = movieEntity["mpaa_rating"];
        var year = movieEntity["year"] ;
        movieCard.movieTitle.text = movieEntity["title"] as? String;
        movieCard.movieSynopsis.text = movieEntity["synopsis"] as? String;
        movieCard.movieAttributes.text = "\(rating), (\(year))";
        var posters = movieEntity["posters"] as NSDictionary;
        var posterUrl = posters["profile"] as? String;
        movieCard.moviePoster.setImageWithURL(NSURL(string: posterUrl));
        return movieCard;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if(segue.identifier == "movieDetail"){
            var selected = self.movies[self.moviesList.indexPathForSelectedRow().row];
            var detailView = segue.destinationViewController as MovieDetailViewController
            detailView.movieEntity = selected as NSDictionary;
            detailView.navigationItem.title = selected["title"] as? String;
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        println(searchText);
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        println("while searching before");
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        println("Hello World");
        println("after searching complete");
        return true
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar!) -> Bool   {
        println("Begin Search");
        println(searchBar.text);
        return true;
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar!)    {
        println("Editing Search");
        println(searchBar.text);
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar!){
        println("Search Ends");
    }
    
    func searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController!){
        println("Start search display Method 1");
    }
    func searchDisplayControllerDidBeginSearch(controller: UISearchDisplayController!){
        println("Start search display Method 2");
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
