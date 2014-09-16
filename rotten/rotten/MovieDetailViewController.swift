//
//  MovieDetailViewController.swift
//  rotten
//
//  Created by Mahadevan, Ramesh on 9/14/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movieEntity: NSDictionary!
    
    @IBOutlet weak var detailPane: UIScrollView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieAttributes: UILabel!
    
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var posters = movieEntity["posters"] as NSDictionary;
        var posterImage = posters["detailed"] as NSString;
        moviePoster.setImageWithURL(NSURL(string: posterImage));
        
        moviePoster.setImageWithURL(NSURL(string: posterImage.stringByReplacingOccurrencesOfString("tmb", withString: "det")));

        
        var title = movieEntity["title"] as NSString;
        var year = movieEntity["year"] as NSInteger;
        
        movieTitle.text = "\(title) (\(year))";
        movieRating.text = movieEntity["mpaa_rating"] as NSString;
        movieSynopsis.text = movieEntity["synopsis"] as NSString;


        var rating = movieEntity["ratings"] as NSDictionary;
        var audienceScore = rating["audience_score"] as NSInteger;
        var criticsScore = rating["critics_score"] as NSInteger;
        movieAttributes.text = "Critics Score: \(criticsScore), Audience Score: \(audienceScore)";
        detailPane.contentSize = CGSize(width:movieSynopsis.frame.width, height:(movieSynopsis.frame.height + movieSynopsis.frame.origin.y));
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
