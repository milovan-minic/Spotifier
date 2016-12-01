//
//  TrackController.swift
//  Spotifier
//
//  Created by iosakademija on 11/24/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import UIKit
import CoreData

class TrackController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let arr = try? moc?.fetch(fetchRequest)
        let path: Spotify.Path = .search(q: "taylor", type: .artist)
        Spotify.shared.call(path) {
            json, error in
            
            // process JSON or errors
        }
        
    }
    
    lazy var frc: NSFetchedResultsController<Track> = {
        let fetchRequest: NSFetchRequest<Track> = Track.fetchRequest()
        //        fetchRequest.fetchLimit = 10
        
        let predicate = NSPredicate(format: "%K like %@", Track.Attributes.name.rawValue, "house")
        fetchRequest.predicate = predicate
        
        let sort0 = NSSortDescriptor(key: "album.name", ascending: true)
        let sort1 = NSSortDescriptor(key: Track.Attributes.name.rawValue, ascending: true)
        let sort2 = NSSortDescriptor(key: Track.Attributes.name.rawValue, ascending: false)
        
        fetchRequest.sortDescriptors = [sort0, sort1, sort2]
        
        let nsfrc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.moc!, sectionNameKeyPath: "album.name", cacheName: nil)
        // TODO napraviti enume i zameniti "album.name" njime
        
        nsfrc.delegate = self
        
        return nsfrc
    }()
    
    var moc: NSManagedObjectContext? {
        didSet {
            if !self.isViewLoaded { return }
            
            self.tableView.reloadData()
        }
    }
}


// MARK: - Table view data source

extension TrackController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard let _ = moc else { return 1 }
        
        guard let sections = frc.sections else { return 1 }
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let _ = moc else { return 0 }
        
        guard let sections = frc.sections else { return 0 }
        return sections[section].numberOfObjects
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrackCell.self), for: indexPath)
        
        // Configure the cell...
        
        let item = frc.object(at: indexPath)
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
}


extension TrackController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}



