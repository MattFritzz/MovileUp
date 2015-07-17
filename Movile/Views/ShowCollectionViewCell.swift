//
//  ShowCollectionViewCell.swift
//  Movile
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class ShowCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        return super.prepareForReuse()
    }
}