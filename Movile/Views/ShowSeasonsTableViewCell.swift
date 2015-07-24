//
//  ShowSeasonsTableViewCell.swift
//  Movile
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowSeasonsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var seasonTitle: UILabel!
    @IBOutlet weak var episodesCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadImage(season: Season!) {
        let placeholder = UIImage(named: "poster")
        if let url = season.thumbImageURL {
            seasonImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            seasonImage.image = placeholder
        }
    }
}
