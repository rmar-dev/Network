//
//  PhotoCellsView.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 28/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import UIKit

class PhotoCellsView: UICollectionViewCell {
    
    var stringURL: URL?
    var photo: PhotoViewModel?{
        didSet{
            guard let url = photo?.flickrImageURL("m")  else {
                return
            }
            stringURL = url
            title.text = photo?.photo.title
        }
    }
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let title: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(_ indexPath: IndexPath, handler: @escaping (_ image: UIImage,_ url: String?) -> ()){
        guard let url = stringURL  else {
            return
        }
        photo?.downloadImage(url, indexPath){ (image, index, url) in
            if let img = image{
                handler(img, url?.absoluteString)
                //self.imageView.image = img
                
            }
        }
    }
    
    private func buildCellView(){
        
        addSubview(imageView)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40),
            title.widthAnchor.constraint(equalTo: widthAnchor),
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}
