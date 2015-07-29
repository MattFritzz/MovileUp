//
//  ShowsCollectionView.swift
//  Movile
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import Alamofire
import Result
import TraktModels
import Kingfisher
import DZNEmptyDataSet

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.hidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.hidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView where view.bounds.height <= 1.0 {
            return imageView
        }
        
        let subviews = view.subviews as! [UIView]
        for subview in subviews {
            if let imageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

class CollectionViewShowViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    @IBOutlet weak var popFav: UISegmentedControl!
    @IBOutlet weak var showsCollectionView: UICollectionView!
    
    var popularShows = [Show]()
    var favoriteShows = [Show]()
    let trkt = TraktHTTPClient()
    let fav = FavoritesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trkt.getPopularShows({ (result) -> Void in
            self.popularShows = result.value!
            self.showsCollectionView.reloadData()
        })
        
        self.showsCollectionView.emptyDataSetDelegate = self
        self.showsCollectionView.emptyDataSetSource = self
        
        //observador para dar reloadData quando um favorito na outra janela é adicionado
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: "favoritesChanged", name: name, object: nil)
    }
    
    deinit {
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: name, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hideBottomHairline()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.showBottomHairline()
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let att = [NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        let mensagem = NSAttributedString(string: "No shows found", attributes: att)
        
        return mensagem
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "favs")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowInfo"{
            if let cell = sender as? ShowCollectionViewCell,
                indexPath = showsCollectionView.indexPathForCell(cell) {
                    let vc = segue.destinationViewController as! ShowViewController
                    if popFav.selectedSegmentIndex == 0 {
                        vc.show = popularShows[indexPath.item]
                    } else {
                        vc.show = favoriteShows[indexPath.item]
                    }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if popFav.selectedSegmentIndex == 0 {
            return popularShows.count
        } else if popFav.selectedSegmentIndex == 1 {
            return favoriteShows.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.CollectionBasicCell.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowCollectionViewCell
        
        if popFav.selectedSegmentIndex == 0 {
            cell.loadShow(popularShows[indexPath.row])
            cell.showName.text = self.popularShows[indexPath.item].title
        } else if popFav.selectedSegmentIndex == 1 {
            cell.loadShow(favoriteShows[indexPath.row])
            cell.showName.text = favoriteShows[indexPath.item].title
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        
        return UIEdgeInsets(top: CGFloat(14), left: space,
        bottom: flowLayout.sectionInset.bottom, right: space)
    }
    
    @IBAction func scValueChanged(sender: UISegmentedControl) {
        favoritesChanged()
        self.showsCollectionView.reloadData()
    }
    
    func favoritesChanged() {
        self.favoriteShows.removeAll(keepCapacity: true)
        
        for show in popularShows {
            if fav.favoritesIdentifiers.contains(show.identifiers.trakt) {
                self.favoriteShows.append(show)
                self.showsCollectionView.reloadData()
            }
        }
        self.showsCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
          //  self.performSegue("ShowEpisodes", sender: cell)
        //}
        
        
        //let alert = UIAlertController(title: "Show Info", message: "Show name: " + popularShows[indexPath.item].title, preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            //self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}
