////
////  CustomImageView.swift
////  NetworkCalls
////
////  Created by Ricardo Rabeto on 12/10/2019.
////  Copyright © 2019 Ricardo Rabeto. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class CustomImageView: UIImageView {
//    
//    var imageUrlString: String?
//    
//    func loadImageUsingUrlString(photo: PhotoViewModel){
//        
//         ImageDownloadManager.shared.downloadImage(photo) { (image, newUrl, error) in
//                        if let error = error {
//                            print(error)
//                            return
//                        }
//                        
//                        
//                        if let photoUrl = newUrl{
//        //                    print("""
//        //                        this is the comparison between urls
//        //                          \(url), \(photoUrl)
//        //                        """)
//                        }
//                        DispatchQueue.main.async {
////                            if let updateCell = collectionView.cellForItem(at: index) as? PhotoCellsView {
////                                updateCell.imageView.image = image
////                            }
//                            
//                        }
//                        
//                        
//                    }
//    }
//}
