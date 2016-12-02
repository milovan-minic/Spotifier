//
//  DataManager.swift
//  Spotifier
//
//  Created by iosakademija on 12/2/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation
import CoreData

final class DataManager {
    
    func search(for string: String, type: Spotify.SearchType) {
        
        let path: Spotify.Path = .search(q: "taylor", type: .atist)
        Spotify.shared.call(path: path) {
            json, error in
            
            if let _ = error {return}
            
            // Process JSON or errors
            
        }
        
    }
    
}

