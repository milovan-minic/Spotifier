//
//  Spotify.swift
//  Spotifier
//
//  Created by iosakademija on 11/29/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation

final class Spotify {
    
    // Beginning of Singleton
    static let shared = Spotify()
    private init() {}
    // Ending of Singleton
    
    static let baseURL: URL = {
        guard let url = URL(string: "https://api.spotify.com/v1/") else { fatalError("Can't create base url!") }
        return url
    }()
    
    static let commonHeaders: [String: String] = {
        return [
            "User-Agent": "Spotifier/1.0",
            "Accept": "application/json",
            "Accept-Charset": "utf-8",
            "Accept-Encoding": "gzip, deflate"
        ]
    }()
    
}

extension Spotify {
    
    enum Method: String {
        case GET, POST, PUT, DELETE
    }
    
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
        
        private var method: Method {
            return .GET
        }
        
        private var headerFields: [String: String] {
//            var headers = commonHeaders
//            switch self {
//            case .albums:
//                headers["Accept"] = "text/html"
//            default:
//                break
//            }
//            return headers
            return commonHeaders
        }
        
        private var fullURL: URL {
            var path = ""

            switch self {
//            case .search(let q, let type):
            case .search:
                path  = "search"
            case .artists(let id, let type):
                let t = type
                path = "artists/\(id)/\(t)"
            default:
                break
            }
            
            return baseURL.appendingPathComponent(path)
        }
        
        private var params: [String: String] {
            var p = [String: String]()
            
            switch self  {
            case .search(let q, let type):
                p["q"] = q
                p["type"] = type.rawValue
            default:
                break
            }
            
            return p
        }
        
        private func queryEncoded(params: [String: String]) -> String {
            if params.count == 0 {return ""}
            
            var arr = [String]()
            for (key, value) in params {
                let s = "\(key)=\(value)"
                arr.append(s)
            }
            
            return arr.joined(separator: "&")
        }
        
        var urlRequest: URLRequest {
            // ne radi jer se enkodira i "?" karakter
//            var r = URLRequest(url: fullURL.appendingPathComponent(queryEncoded(params: params)))
            
            guard var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false) else {fatalError("Invalid URL!")}
            components.query = queryEncoded(params: params)
            
            guard let url = components.url else {fatalError("Invalid URL!")}
            
            var r = URLRequest(url: url)
            
            r.httpMethod = method.rawValue
            r.allHTTPHeaderFields = headerFields
            
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
                let json = obj as? JSON
                else {
                    completion(nil, nil)
                    return
            }
            
            completion(json, nil)
        }
        
        task.resume()
    }
}






























