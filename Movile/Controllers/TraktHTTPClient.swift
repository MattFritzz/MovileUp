//
//  TraktHTTPClient.swift
//  Movile
//
//  Created by iOS on 7/22/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Alamofire
import Result
import TraktModels

class TraktHTTPClient {
    
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"] = "a1cfc8193273f31196b4d9141fb71d7bcb5b580fde678574ea2201abe1eeb99f"
    
            configuration.HTTPAdditionalHeaders = headers
    
            return configuration
            }()
        
        return Manager(configuration: configuration)
    }()
    
    private enum Router: URLRequestConvertible {
        static let baseURLString = "https://api-v2launch.trakt.tv/"
                
        case PopularShows
        case Show(String)
        case Episode(String, Int, Int)
                
        // MARK: URLRequestConvertible
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
                switch self {
                case .PopularShows:
                    return ("shows/popular", ["limit": 50, "extended": "images"], .GET)
                case .Show (let id):
                    return ("shows/\(id)", ["extended" : "images, full"], .GET)
                case .Episode(let id, let season, let number):
            return ("shows/\(id)/seasons/\(season)/episodes/\(number)", ["extended" : "images"], .GET)
                }
            }()
        
            let URL = NSURL(string: Router.baseURLString)!
            let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
        
            let encoding = Alamofire.ParameterEncoding.URL
        
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
    
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        manager.request(Router.Show(id)).validate().responseJSON { (_, _, response, error) in
            
            if let json = response as? NSDictionary {
                
                if let show = Show.decode(json) {
                    completion?(Result.success(show))
                } else {
                    completion?(Result.failure(nil))
                }
            } else {
                completion?(Result.failure(error))
            }
        }
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?) {
        manager.request(Router.Episode(showId, season, episodeNumber)).validate().responseJSON { (_, _, response, error) in
            //FAZER GENERICS!!!
            if let json = response as? NSDictionary {
                
                if let episode = Episode.decode(json) {
                    completion?(Result.success(episode))
                } else {
                    completion?(Result.failure(nil))
                }
            } else {
                completion?(Result.failure(error))
            }
        }

    }
    
    
}