////
////  MovieCellViewModel.swift
////  NetworkCalls
////
////  Created by Ricardo Rabeto on 13/10/2019.
////  Copyright © 2019 Ricardo Rabeto. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//struct BaseModelWithimage{
//    
//    typealias ImageHandler = (_ image: UIImage?,_ urlString: URL?) ->()
//    
//    enum ImageSize {
//        case small
//        case medium
//        case large
//        case custom(size:Int)
//    }
//
//    var imageBaseUrl: String {
//        switch NetworkManager.enviroment {
//        case .production: return "https://image.tmdb.org/t/p/"
//        case .qa:  return "https://image.tmdb.org/t/p/"
//        case .staging:  return "https://image.tmdb.org/t/p/"
//            
//        }
//    }
//    
//    var baseURL: URL {
//        guard let url = URL(string: imageBaseUrl) else { fatalError("baseURL could not be configured.")}
//        return url
//    }
//    
//    let movie: Movie
//    
//    init(movie: Movie){
//        self.movie = movie
//    }
//    
//    func imageUrl( width: Int = 200) -> URL? {
//        if let url = URL(string:"\(imageBaseUrl)w\(width)/\(movie.posterPath)"){
//            return url
//        }
//        return nil
//    }
//    
//    func downloadImage(_ url: URL, complection: @escaping ImageHandler){
//        ImageDownloadManager.shared.downloadImage(url) { (image, newUrl, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            complection(image, newUrl)
//        }
//    }
//}
