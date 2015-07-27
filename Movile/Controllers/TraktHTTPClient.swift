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
    
    
    
    private enum Router: URLRequestConvertible {
        static let baseURLString = "https://api-v2launch.trakt.tv/"
                
        case PopularShows
        case Show(String)
        case Episode(String, Int, Int)
        case Season(String)
        case Episodes(String, Int)
                
        // MARK: URLRequestConvertible
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
                switch self {
                case .PopularShows:
                    return ("shows/popular", ["limit": 50, "extended": "full,images"], .GET)
                case .Show (let id):
                    return ("shows/\(id)", ["extended" : "images, full"], .GET)
                case .Episode(let id, let season, let number):
                    return ("shows/\(id)/seasons/\(season)/episodes/\(number)", ["extended" : "images"], .GET)
                case .Season(let id):
                    return ("shows/\(id)/seasons", ["extended" : "full,images"], .GET)
                case .Episodes(let id, let season):
                    return ("shows/\(id)/seasons/\(season)", ["extended" : "full,images"], .GET)
                }
            }()
        
            let URL = NSURL(string: Router.baseURLString)!
            let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
        
            let encoding = Alamofire.ParameterEncoding.URL
        
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
    
    //Pegam apenas um item
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
        getJSONObject(Router.Show(id), completion: completion)
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?) {
        let episodeRouter = Router.Episode(showId, season, episodeNumber)
        getJSONObject(episodeRouter, completion: completion)
    }
    
    //pegam uma array de itens
    func getPopularShows(completion: ((Result<[Show], NSError?>) -> Void)?) {
        getJSONArrayObject(Router.PopularShows, completion: completion)
    }
    
    func getSeasons(showId: String, completion: ((Result<[Season], NSError?>) -> Void)?) {
        var v = [Season]()
        manager.request(Router.Season(showId)).validate().responseJSON { (_, _, response, error) in
            if let json = response as? [NSDictionary] {
                for item in json {
                    if item["aired_episodes"] as? Int > 0 && item["number"] as? Int > 0 {
                        if let value = Season.decode(item) {
                            v.append(value)
                        } else {
                            completion?(Result.failure(nil))
                            v.removeAll(keepCapacity: false)
                            break
                        }
                    }
                }
                
                if v.count > 0 {
                    completion?(Result.success(v))
                }
            } else {
                completion?(Result.failure(error))
            }
        }

    }
    
    func getEpisodes(showId: String, season: Int, completion: ((Result<[Episode], NSError?>) -> Void)?) {
        getJSONArrayObject(Router.Episodes(showId, season), completion: completion)
    }
    
    private func getJSONArrayObject<T: JSONDecodable>(router: Router, completion: ((Result<[T], NSError?>) -> Void)?) {
        var v = [T]()
        manager.request(router).validate().responseJSON { (_, _, response, error) in
            if let json = response as? [NSDictionary] {
                for item in json {
                    if let value = T.decode(item) {
                        v.append(value)
                    } else {
                        completion?(Result.failure(nil))
                        v.removeAll(keepCapacity: false)
                        break
                    }
                }
                
                if v.count > 0 {
                    completion?(Result.success(v))
                }
            } else {
                completion?(Result.failure(error))
            }
        }
    }
    
    private func getJSONObject<T: JSONDecodable>(router: Router, completion: ((Result<T, NSError?>) -> Void)?) {
            manager.request(router).validate().responseJSON { (_, _, response, error) in
                if let json = response as? NSDictionary {
                    if let value = T.decode(json) {
                        completion?(Result.success(value))
                    } else {
                        completion?(Result.failure(nil))
                    }
                } else {
                    completion?(Result.failure(error))
                }
            }
    }
    
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
}