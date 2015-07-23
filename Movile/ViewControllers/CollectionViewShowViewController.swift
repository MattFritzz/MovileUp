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

class CollectionViewShowViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var showsCollectionView: UICollectionView!
    
    var popularShows = [Show]()
    let trkt = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trkt.getPopularShows({ (result) -> Void in
            self.popularShows = result.value!
            self.showsCollectionView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEpisodes"{
            if let cell = sender as? ShowCollectionViewCell,
                indexPath = showsCollectionView.indexPathForCell(cell) {
                    let vc = segue.destinationViewController as! EpisodesViewController
                    vc.show = popularShows[indexPath.row]
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularShows.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.CollectionBasicCell.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowCollectionViewCell
        cell.showName.text = self.popularShows[indexPath.item].title
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
          //  self.performSegue("ShowEpisodes", sender: cell)
        //}
        
        
        //let alert = UIAlertController(title: "Show Info", message: "Show name: " + popularShows[indexPath.item].title, preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            //self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}
