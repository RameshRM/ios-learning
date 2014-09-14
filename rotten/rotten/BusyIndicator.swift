//
//  BusyIndicator.swift
//  rotten
//
//  Created by Mahadevan, Ramesh on 9/13/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class BusyIndicator: UIView {

    var loadingView: UIView = UIView()
    var container: UIView = UIView()
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()

    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    required override init() {
        super.init();
        self.setup();
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    func busy(baseUIView : UIView)->Void{
        var center = baseUIView.center;
        var frame = baseUIView.frame;
        
        self.container.frame = frame;
        self.container.center = center;
        loadingView.center = center;
        
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        baseUIView.addSubview(container)
        actInd.startAnimating()
        
    }
    
    func free()->Void{
        container.removeFromSuperview()
        actInd.stopAnimating()
        
    }
    
    private func setup()->Void{
        container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
        loadingView.frame = CGRectMake(0, 0, 60, 60)
        loadingView.backgroundColor = UIColorFromHex(0x007700, alpha: 0.7)
        loadingView.opaque=true;
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 3
        
        actInd.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2);
    }
    
    override func addSubview(view: UIView!) {
        view.alpha = 0.5
        super.addSubview(view) // if necessary you can call the super function
    }
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
