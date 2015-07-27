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
    
    
    @IBOutlet weak var uiNavigation: UINavigationItem!
    @IBOutlet weak var episodesTableView: UITableView!
    
    var episodes = [Episode]()
    var show: Show!
    var season: Season!
    let tktv = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tktv.getEpisodes(show.identifiers.slug!, season: season.number, completion: { (result) -> Void in
            
            if let episodes = result.value {
                self.episodes = episodes
                self.episodesTableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Erro!", message: "Não foi possível carregar os episódios", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)

            }
            
            
            self.uiNavigation.title = self.show.title
        })
        
        //tira as linhas do final da tabela quando as rows acabam
        episodesTableView.tableFooterView = UIView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.BasicCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EpisodesTableViewCell
        
        let episode = episodes[indexPath.row]
        cell.seasonEpisode.text = "S" + String(format: "%02d", episode.seasonNumber) + "E" + String(format: "%02d", episode.number)
        cell.episodeName.text = episode.title
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EpisodeOverview"{
            if let cell = sender as? UITableViewCell,
                indexPath = episodesTableView.indexPathForCell(cell) {
                    let vc = segue.destinationViewController as! ShowOverviewViewController
                    vc.episode = episodes[indexPath.row]
                    vc.show = show
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        self.performSegueWithIdentifier("EpisodeOverview", sender: cell)
//        let alert = UIAlertController(title: "Episode Info", message: "Episode name: " + episodeName[indexPath.item], preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//        
//        self.presentViewController(alert, animated: true, completion: nil)
    }
}
