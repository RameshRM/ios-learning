//
//  TwitterOAuthClient.swift
//  TweetClient
//
//  Created by Mahadevan, Ramesh on 9/28/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit
let apiBaseURL = NSURL(string: "https://api.twitter.com");
let consumerKey = "2HLsr4g6n9sgATMQq7Z97ex9S";
let consumerSecret = "tJQ7iAdPh8Dr7g75IFy2J2zNPMaxHtwxf4fPmC9qzj6WjDW6gW";

class TwitterOAuthClient: BDBOAuth1RequestOperationManager {
    var _onLoginCallback: ((user: NSObject!, error: NSError!) -> ())?
    
    class var  instance : TwitterOAuthClient{
        
    struct OAuthClientInstance{
        static let instance = TwitterOAuthClient(baseURL: apiBaseURL, consumerKey: consumerKey , consumerSecret: consumerSecret);
        }
        return OAuthClientInstance.instance;
    }
    
    
    func onAuthCompleted(callback: (user: NSObject!, error: NSError!) -> ()){
        self._onLoginCallback = callback;
        TwitterOAuthClient.instance.requestSerializer.removeAccessToken();
        TwitterOAuthClient.instance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"goliamania-tweetclient://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)");
            UIApplication.sharedApplication().openURL(authURL);
            println("Obtained Token");
            println(requestToken);
            }) { (error: NSError!) -> Void in
                println("Failed to Obtain Token");
                self._onLoginCallback?(user: nil, error: error);
                
        }
    }
    
    func openCallbackUrl(url: NSURL){
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken:BDBOAuthToken!) -> Void in
            TwitterOAuthClient.instance.requestSerializer.saveAccessToken(accessToken);
            TwitterOAuthClient.instance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    var user = response as NSDictionary;
                    println(user);

                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Error while authorizing user");
            })
            }) { (error: NSError!) -> Void in
                println("Error while fetching access token");
        }
    }
    
}
