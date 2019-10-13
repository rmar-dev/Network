//
//  CustomTabBarController.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 28/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white

        tabBar.barTintColor = .black
        tabBar.unselectedItemTintColor = .white
        tabBar.isTranslucent = false
        tabBar.tintColor = .orange

        let galeryController = GaleryController(collectionViewLayout: layout)
        let galeryNavController = UINavigationController(rootViewController: galeryController)
        galeryController.tabBarItem.image = UIImage(named: "popcorn")
        galeryController.tabBarItem.title = ""
        
        let movieController = MovieController(collectionViewLayout: layout)
        let movieNavController = UINavigationController(rootViewController: movieController)
        movieNavController.tabBarItem.image = UIImage(named: "tape")
        movieNavController.tabBarItem.title = ""
        
        viewControllers = [galeryNavController, movieNavController]
    }
}
