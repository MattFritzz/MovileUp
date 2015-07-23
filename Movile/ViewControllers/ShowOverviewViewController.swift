//
//  MyViewController.swift
//  Movile
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowOverviewViewController : UIViewController {
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    var episode: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
        
        //bannerImage.image = UIImage(CGImage: NSData(contentsOfURL: episode.screenshot?.fullImageURL))
        showTitle.text = "Episódio \(episode.number)"
        overviewTextView.text = episode.overview
    }
}
