//
//  FavoritesManager.swift
//  Movile
//
//  Created by iOS on 7/28/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import SwiftyUserDefaults

class FavoritesManager {
    let defaults = NSUserDefaults.standardUserDefaults()
    static let favoritesChangedNotificationName = "com.movile.favoritesChanged"
    
    var favoritesIdentifiers: Set<Int> {
        var favorites = defaults.objectForKey("favs") as? Array<Int> ?? []
        return Set(favorites)
    }
    
    func addIdentifier(identifier: Int) {
        var identifiers = favoritesIdentifiers
        identifiers.insert(identifier)
        
        
        defaults.setObject(Array(identifiers), forKey: "favs")
        defaults.synchronize()
    }
    
    func removeIdentifier(identifier: Int) {
        var identifiers = favoritesIdentifiers
        identifiers.remove(identifier)
        
        defaults.setObject(Array(identifiers), forKey: "favs")
    }
}