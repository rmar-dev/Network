//
//  NetworkManager.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 27/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case sucess
    case failure(String)
}

struct NetworkImageManager {
    
    static let shared = NetworkImageManager()
    private var completionHandler: ImageDownloadHandler?

    static let enviroment: NetworkEnvironment = .production
    static let ApiKey = "42fe41a1dbb823a8e32fff8535269d74"
    static let secret = "d993925b5c8c5197"
    private let router = Router<FlickrApi>()
    
    func getNewSearchImage(text: String, complection: @escaping(_ photos: [Photo]?,_ error: String?)->()){
        router.request(.photosSearch(text: text)) { data, res, err in
            if err != nil {
                complection(nil, "Please check your connection.")
            }
            guard let response = res as? HTTPURLResponse else { return }
            let result = handleNetworkResponse(response)
            switch result {
            case .sucess:
            guard let responseData = data else {
                complection(nil, NetworkResponse.noData.rawValue)
                return
            }
            do{
                let apiResponse = try JSONDecoder().decode(PhotosApiResponse.self, from: responseData)
                complection(apiResponse.photos.photos, nil)
            }catch{
                complection(nil, NetworkResponse.unableToDecode.rawValue)
            }
            case .failure(let networkFailureError):
                complection(nil, networkFailureError)
            }
            
        }
    }
}


struct NetworkManager {
    static let shared = NetworkManager()
    static let enviroment : NetworkEnvironment = .production
    static let MovieAPIKey = "0021a23bfb885072bce112e519e7381c"
    private let router = Router<MovieApi>()
  
    
    func getPopularMovies(page: Int, complection: @escaping(_ movie: [Movie]?,_ error: String?)->()){
        router.request(.popular(page: page)) { data, response, error in
            if error != nil {
                complection(nil, "Please check your connection.")
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            let result = handleNetworkResponse(response)
            
            switch result{
            case .sucess:
                guard let responseData = data else {
                    complection(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do{
                    let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                    complection(apiResponse.movies, nil)
                }catch{
                    complection(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                complection(nil, networkFailureError)
            }
        }
    }
   
    func getNewMovies(page: Int, complection: @escaping(_ movie: [Movie]?,_ error: String?)->()){
        router.request(.newMovies(page: page)) { data, response, error in
            if error != nil {
                complection(nil, "Please check your connection.")
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            let result = handleNetworkResponse(response)
            
            switch result{
            case .sucess:
                guard let responseData = data else {
                    complection(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do{
                    let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                    complection(apiResponse.movies, nil)
                }catch{
                    complection(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                complection(nil, networkFailureError)
            }
        }
    }
    func getDetails(id: Int, complection: @escaping(_ details: DetailsModel?,_ error: String?)->()){
        router.request(.getDetails(id: id)) { data, response, error in
            if error != nil {
                complection(nil, "Please check your connection.")
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            let result = handleNetworkResponse(response)
            
            switch result{
            case .sucess:
                guard let responseData = data else {
                    complection(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do{
                    let apiResponse = try JSONDecoder().decode(DetailsModel.self, from: responseData)
                    complection(apiResponse, nil)
                }catch{
                    complection(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                complection(nil, networkFailureError)
            }
        }
    }
}


fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode {
    case 200...299: return .sucess
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
}
