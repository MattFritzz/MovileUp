//
//  StorylineContainerViewController.swift
//  Movile
//
//  Created by iOS on 7/29/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class StorylineContainerViewController: UIViewController, InternalViewController {

    @IBOutlet weak var storylineTextView: UITextView!
    
    var show: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storylineTextView.text = show.overview
        storylineTextView.textContainer.lineFragmentPadding = 0
        storylineTextView.textContainerInset = UIEdgeInsetsZero
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func instrinsicContentSize() -> CGSize {
        let height: CGFloat = (self.view.frame.height - storylineTextView.frame.maxY) + storylineTextView.frame.maxY + storylineTextView.frame.minY
        
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
