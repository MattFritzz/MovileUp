//
//  TableViewEpisodesViewControler.swift
//  Movile
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class EpisodesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let seasonEpisode = ["S03E01", "S03E2", "S03E3", "S03E4", "S03E5"]
    let episodeName = ["Winter is Coming", "Snow", "Arya", "The North Remembers", "White Wolf"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tira as linhas do final da tabela quando as rows acabam
        tableView.tableFooterView = UIView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonEpisode.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.BasicCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EpisodesTableViewCell
        cell.seasonEpisode.text = seasonEpisode[indexPath.row]
        cell.episodeName.text = episodeName[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Episode Info", message: "Episode name: " + episodeName[indexPath.item], preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

