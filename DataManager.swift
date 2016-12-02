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
    
    // Creating Singleton
    static let shared = DataManager()
    private init() {}
    // Creating Singleton
    
    func search(for string: String, type: Spotify.SearchType) {
        
        let path: Spotify.Path = .search(q: string, type: type)
        Spotify.shared.call(path: path) {
            json, error in
            
            if let _ = error {return}
            
            // Process JSON or errors
            
        }
        
    }
    
}

