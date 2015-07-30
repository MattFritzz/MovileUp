//
//  ShowGenresViewController.swift
//  Movile
//
//  Created by iOS on 7/30/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import TagListView

class ShowGenresViewController: UIViewController, InternalViewController {

    @IBOutlet weak var genres: TagListView!
    
    var show: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in show.genres! {
            genres.addTag(item)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intrinsicContentSize() -> CGSize {
        let height = (self.view.frame.height - genres.frame.maxY) + genres.intrinsicContentSize().height + genres.frame.minY
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
