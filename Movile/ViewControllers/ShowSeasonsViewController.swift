//
//  ShowSeasonsViewController.swift
//  Movile
//
//  Created by iOS on 7/30/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowSeasonsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, InternalViewController {

    @IBOutlet weak var seasonsTableView: UITableView!
    
    var show: Show!
    var showSeasons = [Season]()
    let tktv = TraktHTTPClient()
    let formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //popula a seasonsTableView com informações
        tktv.getSeasons(show.identifiers.slug!, completion: { result in
            if let seasons = result.value {
                self.showSeasons = reverse(seasons)
                self.seasonsTableView.reloadData()
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
        
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        cell.ratingNumber.text = formatter.stringFromNumber(showSeasons[indexPath.row].rating!)
        cell.ratingStars.rating = (showSeasons[indexPath.row].rating!)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intrinsicContentSize() -> CGSize {
        let height = seasonsTableView.frame.minY + seasonsTableView.contentSize.height
        return CGSize(width: self.view.frame.width, height: height)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SeasonEpisodes" {
            if let cell = sender as? ShowSeasonsTableViewCell,
                indexPath = seasonsTableView.indexPathForCell(cell) {
                    let vc = segue.destinationViewController as! EpisodesViewController
                    vc.show = self.show
                    vc.season = self.showSeasons[indexPath.row]
            }
        }
    }

}
