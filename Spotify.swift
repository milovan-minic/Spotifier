//
//  Spotify.swift
//  Spotifier
//
//  Created by iosakademija on 11/29/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation

final class Spotify {
    
    static let shared = Spotify() // singleton
    private init() {} // singleton
    
    static let baseURL: URL = {
        guard let url = URL(string: "https://api.spotify.com/v1/") else { fatalError("Can't create base url!") }
        return url
    }()
    
}

extension Spotify {
    enum SearchType: String {
        case atist
        case album
        case track
        case playlist
    }
    
    enum ItemType: String {
        case albums
        case topTracks
        case relatedArtists
        
        case tracks
        
        fileprivate var apiValue: String {
            switch self {
            case .topTracks:
                return "top-tracks"
            case .relatedArtists:
                return "related-artists"
            default:
                return self.rawValue
            }
        }
    }
    
    enum Path {
        case search(q: String, type: SearchType)
        case artists(id: String, type: ItemType?)
        case albums(id: String, type: ItemType?)
        
        private var fullURL: URL {
            var path = ""

            switch self {
            case .search(let q, let type):
                path  = "search"
            case .artists(let id, let type):
                let t = type
                path = "artists/\(id)/\(t)"
            default:
                break
            }
            
            return baseURL.appendingPathComponent(path)
        }
        
        var urlRequest: URLRequest {
            
            var r = URLRequest(url: fullURL)
            
            
            
            return r
        }
    }
    
}


extension Spotify {
    
    typealias JSON = [String: Any]
    typealias Callback = ( JSON?, Error? ) -> Void
    
    func call(path: Path, completion: @escaping Callback) {
        
        let urlRequest = path.urlRequest
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            
            data, urlResponse, error in
            
            // process the returned stuff here
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            
            
            if httpURLResponse.statusCode != 200 {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            guard
                let obj = try? JSONSerialization.jsonObject(with: data),
                let jsnon = obj as? JSON
                else {
                    completion(nil, nil)
                    return
            }
            
            completion(json, nil)
        }
        
        task.resume()
    }
}






























