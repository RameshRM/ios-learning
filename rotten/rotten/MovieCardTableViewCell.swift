//
//  MovieCardTableViewCell.swift
//  rotten
//
//  Created by Mahadevan, Ramesh on 9/11/14.
//  Copyright (c) 2014 GoliaMania. All rights reserved.
//

import UIKit

class MovieCardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieSynopsis: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
