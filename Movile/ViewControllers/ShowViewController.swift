//
//  ShowViewController.swift
//  Movile
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView

protocol InternalViewController: class {
    func intrinsicContentSize() -> CGSize
}

class ShowViewController: UIViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var showRatingNumber: UILabel!
    @IBOutlet weak var showRatingStars: FloatRatingView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var showPoster: UIImageView!
    @IBOutlet weak var detailsConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var genresContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var seasonsContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var storylineContainerHeight: NSLayoutConstraint!
    
    var show: Show!
    let tktv = TraktHTTPClient()
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let formatter = NSNumberFormatter()
    let fav = FavoritesManager()

    weak var storylineViewController: StorylineContainerViewController!
    weak var seasonsViewController: ShowSeasonsViewController!
    weak var genresViewController: ShowGenresViewController!
    weak var detailsViewController: ShowDetailsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholder = UIImage(named: "bg")
        
        //VERIFICAR IMAGEM!!
        if let url = show.thumbImageURL {
            showPoster.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            showPoster.image = placeholder
        }
        
        if fav.favoritesIdentifiers.contains(show.identifiers.trakt) {
            favButton.selected = true
        }
        
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        showRatingNumber.text = formatter.stringFromNumber(show.rating!)
        showRatingStars.rating = (show.rating!)
        
        navTitle.title = show.title
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        storylineContainerHeight.constant = storylineViewController.intrinsicContentSize().height
        seasonsContainerHeight.constant = seasonsViewController.intrinsicContentSize().height
        genresContainerHeight.constant = genresViewController.intrinsicContentSize().height
        detailsConstraintHeight.constant = detailsViewController.intrinsicContentSize().height
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "StorylineSegue" {
            storylineViewController = segue.destinationViewController as! StorylineContainerViewController
            storylineViewController.show = show
        } else if segue.identifier == "SeasonsSegue" {
            seasonsViewController = segue.destinationViewController as! ShowSeasonsViewController
            seasonsViewController.show = self.show
        } else if segue.identifier == "GenresSegue" {
            genresViewController = segue.destinationViewController as! ShowGenresViewController
            genresViewController.show = show
        } else if segue.identifier == "DetailsSegue" {
            detailsViewController = segue.destinationViewController as! ShowDetailsViewController
            detailsViewController.show = show
        }
    }
    
    @IBAction func fabButtonClicked(sender: UIButton) {
        
        let favorited = !sender.selected
        UIView.transitionWithView(sender, duration: 0.4, options: .TransitionCrossDissolve, animations: {
            sender.selected = favorited
            }, completion: nil)
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.4
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = favorited ? 1.2 : 0.8
        
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 1
        
        let function = kCAMediaTimingFunctionEaseInEaseOut
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: function)
        
        sender.layer.addAnimation(pulseAnimation, forKey: nil)
        
        if favorited {
            fav.addIdentifier(show.identifiers.trakt)
        } else {
            fav.removeIdentifier(show.identifiers.trakt)
        }
        
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(name, object: self)
    }
}
