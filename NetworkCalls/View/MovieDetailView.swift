//
//  MovieDetailView.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 13/10/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailView: UIView {
    var posterUtl: URL?
    var backdropUrl: URL?
    var imageBaseUrl: String {
        switch NetworkManager.enviroment {
        case .production: return "https://image.tmdb.org/t/p/"
        case .qa:  return "https://image.tmdb.org/t/p/"
        case .staging:  return "https://image.tmdb.org/t/p/"
            
        }
    }
    var model: DetailsModel?{
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.title.text = self?.model?.title
                if let text = self?.model?.overview{
                    self?.overview.text = text
                }
            }
            
            if let str = model?.backdrop, let url = imageUrl(path: str){
                loadimage(url, complection: {[weak self] (img, url) in
                    DispatchQueue.main.async {
                        if(self?.posterUtl == url){
                            self?.poster.image = img
                        }else{
                            self?.image.image = img
                        }
                    }
                })
                
            }
            if let str = model?.poster, let url = imageUrl(path: str){
                posterUtl = url
                loadimage(url, complection: {[weak self] (img, url) in
                    DispatchQueue.main.async {
                        if(self?.posterUtl == url){
                            self?.poster.image = img
                        }else{
                            self?.image.image = img
                        }
                    }
                })
                
            }
            
            
        }
    }
    
    var image: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .darkGray
        return img
    }()
    var poster: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var title: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    var overview: UITextView = {
        let lbl = UITextView()
        lbl.backgroundColor = .none
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(poster)
        addSubview(title)
        addSubview(overview)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            poster.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -80),
            poster.leftAnchor.constraint(equalTo: image.leftAnchor, constant: 20),
            poster.widthAnchor.constraint(equalToConstant: 90),
            poster.heightAnchor.constraint(equalToConstant: 160),
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.heightAnchor.constraint(equalToConstant: 80),
            title.widthAnchor.constraint(equalToConstant: 100),
            overview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 100),
            overview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             overview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
             overview.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func imageUrl( width: Int = 500, path: String) -> URL? {
        if let url = URL(string:"\(imageBaseUrl)w\(width)\(path)"){
            return url
        }
        return nil
    }
    
    func loadimage(_ url: URL, complection: @escaping (_ image: UIImage,_ url: URL?)->()){
        ImageDownloadManager.shared.downloadImage(url){ (image, url, error) in
            if let err = error{
                print(err)
                return
            }
            if let img = image{
                complection(img, url)
                //self.imageView.image = img
                
            }
        }
    }
    
}
