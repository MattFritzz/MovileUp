//
//  ShowDetailsViewController.swift
//  Movile
//
//  Created by iOS on 7/30/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowDetailsViewController: UIViewController, InternalViewController {

    @IBOutlet weak var detailsTextView: UITextView!
    
    var show: Show!
    var numberOfSeasons = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let d = "Broadcasting: \nStatus: " + show.status!.rawValue + "\nAired episodes: \(show.airedEpisodes) \nRuntime: \(show.runtime) \nNetwork :\(show.network) \n"
        
        detailsTextView.text = d
        detailsTextView.textContainer.lineFragmentPadding = 0
        detailsTextView.textContainerInset = UIEdgeInsetsZero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intrinsicContentSize() -> CGSize {
        let height = (self.view.frame.height - detailsTextView.frame.maxY) + detailsTextView.intrinsicContentSize().height + detailsTextView.frame.minY
        return CGSize(width: self.view.frame.width, height: height)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
