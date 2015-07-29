//
//  TesteViewController.swift
//  Movile
//
//  Created by iOS on 7/29/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

protocol InternalViewController: class {
    func instrinsicContentSize() -> CGSize
}


class TesteViewController: UIViewController {

    @IBOutlet weak var secondContainerHeightConstraint: NSLayoutConstraint!
    
    weak var secondViewController: InternalViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue == Segue.secondContainer {
//            secondViewController = segue.destinationViewController as! InternalViewController
//        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = secondViewController.instrinsicContentSize()
        secondContainerHeightConstraint.constant = size.height
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
