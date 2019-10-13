//
//  ImageDownloadManager.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 28/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import UIKit

class ImageDownloadManager {
    private var completionHandler: ImageDownloadHandler?
    lazy var imageDownloadQueue : OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.NetworkCalls.imageDownloadModel"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageDownloadManager()
    
    func downloadImage(_ url: URL, handler: @escaping ImageDownloadHandler){
        self.completionHandler = handler
//        guard let url = flkPhoto.flickrImageURL(size)  else {
//            return handler(nil, nil, NetworkError.failLoadImage)
//        }
        
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString){
            //check for cache image for url, if yes return cached image
            print("return cache image for url \(url)")
            self.completionHandler?(cacheImage, url, nil)
        }else {
            //check if there is a download task that is currently downloading the same image
            if let operations = (imageDownloadQueue.operations as? [PGOperation])?
                .filter({$0.imageUrl.absoluteString == url.absoluteString && !$0.isFinished && $0.isExecuting}),
                let operation = operations.first
            {
                operation.queuePriority = .high
                
            }else{
                //create a new task to download the image
                print("create a new task to download image for \(url).")
                let operation = PGOperation(url: url)
//                if indexPath == nil {
//                    operation.queuePriority = .veryHigh
//                }
                operation.downloadHandler = {(image, url, error) in
                    guard let newUrl = url else {
                        self.completionHandler?(image, url, error)
                        return
                    }
                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: newUrl.absoluteString as NSString)
                    }
                    self.completionHandler?(image, newUrl, error)
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    /* FUNCTION to reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
    func slowDownImageDownloadTaskfor (_ flickrPhoto: PhotoViewModel) {
        guard let url = flickrPhoto.flickrImageURL() else {
            return
        }
        if let operations = (imageDownloadQueue.operations as? [PGOperation])?.filter({$0.imageUrl.absoluteString == url.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
            print("Reduce the priority for \(url)")
            operation.queuePriority = .low
        }
    }
    
    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
    
}
