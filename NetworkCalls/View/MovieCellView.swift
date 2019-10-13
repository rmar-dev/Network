//
//  MovieCellView.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 13/10/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation
import  UIKit

class MovieCellView: BaseCell{
    
    var movie: MovieCellViewModel?{
        didSet{
            guard let url = movie?.imageUrl() else {
                return
            }
            stringURL = url
            title.text = movie?.movie.title
        }
    }
    
    
    override func loadImage(_ indexPath: IndexPath, handler: @escaping (UIImage, String?) -> ()) {
        guard let url = stringURL  else {
            return
        }
        movie?.downloadImage(url){ (image, url) in
            if let img = image{
                handler(img, url?.absoluteString)
                //self.imageView.image = img
                
            }
        }
    }
    
    
}
