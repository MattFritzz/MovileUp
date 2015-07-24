//
//  MyViewController.swift
//  Movile
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class ShowOverviewViewController : UIViewController {
    
    
    @IBOutlet weak var uiNavigation: UINavigationItem!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var show: Show!
    var episode: Episode!
    let tktv = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
        
        let placeholder = UIImage(named: "bg")
        if let url = episode.screenshot?.mediumImageURL ?? episode.screenshot?.fullImageURL ?? episode.screenshot?.thumbImageURL {
            bannerImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            bannerImage.image = placeholder
        }
        
        uiNavigation.title = "Episode " + String(format: "%02d", episode.number)
        showTitle.text = episode.title
        overviewTextView.text = episode.overview
    }
    
    @IBAction func shareButton(sender: AnyObject) {
        let textToShare = "O episódio \"\(episode.title!)\" da série \(show.title) é maravilhoso!"
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
}
