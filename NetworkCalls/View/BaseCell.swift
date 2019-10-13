//
//  BaseCell.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 13/10/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation
import UIKit
class BaseCell: UICollectionViewCell {
    
    var stringURL: URL?
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage()
        img.backgroundColor = .gray
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
    
    func loadImage(_ indexPath: IndexPath, handler: @escaping (_ image: UIImage,_ url: String?) -> ()){}
    
    private func buildCellView(){
        
        addSubview(imageView)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.widthAnchor.constraint(equalTo: widthAnchor),
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            title.leftAnchor.constraint(equalTo: imageView.leftAnchor)
            
        ])
    }
}
