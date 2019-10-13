//
//  MovieDetailViewModel.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 13/10/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailViewModel {
    var movie: DetailsModel?
    var posterUrl: URL?{
        didSet{
            guard let url = URL(string: movie?.poster ?? "")  else {
                return
            }
            posterUrl = url
        }
    }
    var backdropUrl: String?
    
   
}
