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
        
//        DataManager.shared.search(for: "house", type: .track)
        
    }
    
    lazy var frc: NSFetchedResultsController<Track> = {
        let fetchRequest: NSFetchRequest<Track> = Track.fetchRequest()
        //        fetchRequest.fetchLimit = 10
        
        //		let predicate = NSPredicate(format: "name like 'house'")
        let predicate = NSPredicate(format: "%K contains[cd] %@", Track.Attributes.name, "house")
        fetchRequest.predicate = predicate
        
        let sectionKeyPath = "\(Track.Relationships.album).\(Album.Attributes.name)"
        
        let sort0 = NSSortDescriptor(key: "album.name", ascending: true)
        let sort1 = NSSortDescriptor(key: Track.Attributes.name, ascending: true)
        //		let sort2 = NSSortDescriptor(key: Track.Attributes.name.rawValue, ascending: true)
        
        fetchRequest.sortDescriptors = [sort0, sort1]
        
        let nsfrc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.moc!, sectionNameKeyPath: sectionKeyPath, cacheName: nil)
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
        
        guard let _ = moc else { return 1 }
        
        guard let sections = frc.sections else { return 1 }
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let _ = moc else { return 0 }
        
        guard let sections = frc.sections else { return 0 }
        return sections[section].numberOfObjects
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrackCell.self), for: indexPath)
        
        
        let item = frc.object(at: indexPath)
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.album?.name
        
        return cell
    }
    
}


extension TrackController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}



