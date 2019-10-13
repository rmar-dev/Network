//
//  ViewController.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 26/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import UIKit

class BaseController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var movieList: [MovieCellViewModel]?
    var globalPage = 1;
    let cellId = "cellId"
    var cellsDictionary = [String: IndexPath]()
    func photoForIndexPath(indexPath: IndexPath) -> MovieCellViewModel? {
        if let movies = movieList {
            return movies[(indexPath as NSIndexPath).row]
        }
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Latest Movies"
        navigationController?.tabBarItem.title = ""

        collectionView.register(MovieCellView.self, forCellWithReuseIdentifier: cellId)
        getAssets()
        
    }
    
    func getAssets(page: Int = 1){
        
    }
}

extension BaseController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let val = view.frame.width / 2
        let size = CGSize(width: val, height: val * 1.6)
        
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCellView
        
        if let movies = movieList {
            cell.movie = movies[indexPath.item]
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let displayCell = cell as? MovieCellView, let url = displayCell.stringURL{
            cellsDictionary[url.absoluteString] = indexPath
            displayCell.loadImage(indexPath){[weak self] (image, url) in
                DispatchQueue.main.async {
                    if let url = url, let updateIndex = self?.cellsDictionary[url]{
                        if let updateCell = collectionView.cellForItem(at: updateIndex) as? MovieCellView{
                            updateCell.imageView.image = image

                        }
                    }
                    
                }
            }
        }
        print("visible cell is now on screen \(cell) " )
        if let data = movieList, indexPath.row == data.count - 2 {
            getAssets(page: globalPage)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextController = DetailController()
        nextController.movie = movieList?[indexPath.item]
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        /* Reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
        //if self.loadMore {return}
        let photoFromIndex = photoForIndexPath(indexPath: indexPath)
//        if let flickrPhoto = photoFromIndex {
//            ImageDownloadManager.shared.slowDownImageDownloadTaskfor(flickrPhoto)
//        }
    }
    
}

