//
//  ViewController.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 26/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import UIKit

class GaleryController: BaseController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popular Movies"
        navigationController?.tabBarItem.title = ""

        collectionView.register(MovieCellView.self, forCellWithReuseIdentifier: cellId)
        getAssets()
        
    }
    
    override func getAssets(page: Int = 1){
        globalPage += 1;
        NetworkManager.shared.getPopularMovies(page: page) { [weak self] (movies, error) in
            if let error = error {
                print(error)
            }else{
                if let movies = movies {
                    let newList = movies.map({ return MovieCellViewModel(movie: $0)})
                    let cell = self?.movieList?[0].movie
                    print(cell ?? "nothing in here")
                    if let list = self?.movieList{
                        self?.movieList = list + newList
                    }else{
                        self?.movieList = newList
                    }
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadData()
                        
                    }
                    
                }
            }
        }
    }
}


