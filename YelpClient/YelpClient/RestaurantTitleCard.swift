//
//  RestaurantTitleCard.swift
//  YelpClient
//
//  Created by Mahadevan, Ramesh on 9/22/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class RestaurantTitleCard: UITableViewCell {
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var restaurantTitle: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var reviewStars: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
