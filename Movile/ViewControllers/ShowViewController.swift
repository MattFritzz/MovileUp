//
//  ShowViewController.swift
//  Movile
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var seasonsTableView: UITableView!
    var show: Show!
    var showSeasons = [Season]()
    let tktv = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //popula a seasonsTableView com informações
        tktv.getSeasons(show.identifiers.slug!, completion: { result in
            if let seasons = result.value {
                self.showSeasons = seasons
            } else {
                let alert = UIAlertController(title: "Erro!", message: "Não foi possível carregar as temporadas", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
        
        seasonsTableView.tableFooterView = UIView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showSeasons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.ShowCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! ShowSeasonsTableViewCell
        cell.seasonTitle.text = "Season " + String(format: "%02d", showSeasons[indexPath.row].number)
        cell.episodesCount.text = String(format: "%02d", showSeasons[indexPath.row].episodeCount!) + " episodes"
        cell.loadImage(showSeasons[indexPath.row])
        
        return cell
    }
}
