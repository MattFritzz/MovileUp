//
//  MyViewController.swift
//  Movile
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class ShowOverviewViewController : UIViewController {
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTextView.textContainer.lineFragmentPadding = 0
        overviewTextView.textContainerInset = UIEdgeInsetsZero
    }
}
