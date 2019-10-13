//
//  DetailController.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 13/10/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation
import UIKit
class DetailController: UIViewController{
    var baseView: MovieDetailView = {
        let view = MovieDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var movie: MovieCellViewModel?{
        didSet{
            if let id = movie?.movie.id{
                NetworkManager.shared.getDetails(id: id) {[weak self] (details, error) in
                    if let err = error {
                        print(err)
                        return
                    }
                    print(details)
                    self?.baseView.model = details
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie?.movie.title
        view.backgroundColor = .red
        view.addSubview(baseView)
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
