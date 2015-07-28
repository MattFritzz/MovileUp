//
//  ShowCollectionViewCell.swift
//  Movile
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class ShowCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showName: UILabel!
    private var task: RetrieveImageTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        showImage.image = nil
    }
    
    func loadShow(show: Show) {
        let placeholder = UIImage(named: "poster")
        if let url = show.poster?.thumbImageURL ?? show.poster?.mediumImageURL ?? show.poster?.fullImageURL {
            showImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            showImage.image = placeholder
        }
    }
}

