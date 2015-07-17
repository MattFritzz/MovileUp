//
//  ShowsCollectionView.swift
//  Movile
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class CollectionViewShowViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var showsCollectionView: UICollectionView!
    
    let showName = ["Band of Brothers", "Planet Earth", "Sherlock", "House of Cards", "Breaking Bad", "Game of Thrones", "Firefly", "The Walking Dead", "Fargo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showName.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.CollectionBasicCell.identifier!
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowCollectionViewCell
        cell.showName.text = showName[indexPath.item]
        
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
            let alert = UIAlertController(title: "Show Info", message: "Show name: " + showName[indexPath.item], preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
