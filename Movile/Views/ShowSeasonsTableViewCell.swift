//
//  ShowSeasonsTableViewCell.swift
//  Movile
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher
import FloatRatingView

class ShowSeasonsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var seasonTitle: UILabel!
    @IBOutlet weak var episodesCount: UILabel!
    @IBOutlet weak var ratingStars: FloatRatingView!
    @IBOutlet weak var ratingNumber: UILabel!
    private var task: RetrieveImageTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        seasonImage.image = nil
    }
    
    func loadImage(season: Season!) {
        let placeholder = UIImage(named: "poster")
        if let url = season.poster?.thumbImageURL ?? season.poster?.mediumImageURL ?? season.poster?.fullImageURL {
            seasonImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            seasonImage.image = placeholder
        }
    }
}
