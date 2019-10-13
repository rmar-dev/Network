//
//  EndPointType.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 27/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
    
}

public enum FlickrApi{
    case photosSearch (text: String)
}

extension FlickrApi: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.enviroment {
        case .production: return "https://api.flickr.com/services/rest/?"
        default: return "#"
        }
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .photosSearch : return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .photosSearch(let text):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        "method":"flickr.photos.search",
                                        "text":text,
                                        "nojsoncallback":1,
                                        "format":"json",
                                        "per_page":"20",
                                        "api_key": NetworkImageManager.ApiKey])
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}

public enum MovieApi {
    case recommend(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
    case getDetails(id: Int)
}



extension MovieApi: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.enviroment {
        case .production: return "https://api.themoviedb.org/3/movie"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }
    
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    
    
    var path: String {
        switch self {
        case .recommend(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        case .getDetails(let id):
            return "\(id)"
        }
            
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page), .popular(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        "page":page,
                                        "api_key": NetworkManager.MovieAPIKey])
        case .getDetails(_):
        return .requestParameters(bodyParameters: nil,
                                  urlParameters: [
                                    "api_key": NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
    
}

public enum ImageSize {
    case small
    case medium
    case large
    case custom(size:Int)
}

extension ImageSize: EndPointType {
    //    https://image.tmdb.org/t/p/w500/
    
    var imageBaseUrl: String {
        switch NetworkManager.enviroment {
        case .production: return "https://image.tmdb.org/t/p/"
        case .qa:  return "https://image.tmdb.org/t/p/"
        case .staging:  return "https://image.tmdb.org/t/p/"
            
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: imageBaseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .small:
            return "w200"
        case .medium:
            return "w400"
        case .large:
            return "w600"
        case .custom(let size):
            return "w\(size)"
        }
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
