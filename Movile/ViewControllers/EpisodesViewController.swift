//
//  TableViewEpisodesViewControler.swift
//  Movile
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class EpisodesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    var seasonEpisode = [String]()
    var episodeName = [Episode]()
    var show: Show!
    let tktv = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tktv.getEpisodes(show.identifiers.slug!, season: 1, completion: { (result) -> Void in
            self.episodeName = result.value!
            
            for episode in result.value! {
                self.seasonEpisode.append("S\(episode.seasonNumber)E\(episode.number)")
            }
            
            self.episodesTableView.reloadData()
        })
        
        //tira as linhas do final da tabela quando as rows acabam
        episodesTableView.tableFooterView = UIView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonEpisode.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.BasicCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EpisodesTableViewCell
        cell.seasonEpisode.text = seasonEpisode[indexPath.row]
        cell.episodeName.text = episodeName[indexPath.row].title
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EpisodeOverview"{
            if let cell = sender as? UITableViewCell,
                indexPath = episodesTableView.indexPathForCell(cell) {
                    let vc = segue.destinationViewController as! ShowOverviewViewController
                    vc.episode = episodeName[indexPath.row]
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        self.performSegueWithIdentifier("EpisodeOverview", sender: cell)
//        let alert = UIAlertController(title: "Episode Info", message: "Episode name: " + episodeName[indexPath.item], preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//        
//        self.presentViewController(alert, animated: true, completion: nil)
    }
}
