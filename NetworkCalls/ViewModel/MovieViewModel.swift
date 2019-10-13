//
//  MovieViewModel.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 28/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation

struct MovieViewModel {
    let movie : Movie
    
    // Dependency Injection (DI)
    init(movie: Movie) {
        //apply changes if needed for the values
        //        self.movie = Movie (id: movie.id, posterPath: movie.posterPath, backdrop: movie.backdrop, title: movie.title, releaseDate: movie.releaseDate, rating: movie.rating, overview: movie.overview)
        self.movie = Movie (id: movie.id, posterPath: movie.posterPath, title: movie.title, releaseDate: movie.releaseDate, rating: movie.rating, overview: movie.overview)
        
    }
}
