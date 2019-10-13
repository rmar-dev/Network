//
//  FlickrModel.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 27/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation

struct PhotosApiResponse: Decodable {
    let photos: Photos
    let stat : String
}

struct Photos {
    let page: Int
    let pages: Int
    let perPage: Int
    let total: String
    let photos: [Photo]
}

extension Photos : Decodable {
    
    enum PhotosCodingKeys: String, CodingKey {
        case page
        case pages
        case perPage = "perpage"
        case total
        case photos = "photo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotosCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        pages = try container.decode(Int.self, forKey: .pages)
        perPage = try container.decode(Int.self, forKey: .perPage)
        total = try container.decode(String.self, forKey: .total)
        photos = try container.decode([Photo].self, forKey: .photos)
       
    }
}

struct Photo {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Int
    let isFriend: Int
    let isFamily: Int
}

extension Photo: Decodable {
    enum PhotoCodingKeys: String, CodingKey {
        case id
        case owner
        case secret
        case server
        case farm
        case title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoCodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        owner = try container.decode(String.self, forKey: .owner)
        secret = try container.decode(String.self, forKey: .secret)
        server = try container.decode(String.self, forKey: .server)
        farm = try container.decode(Int.self, forKey: .farm)
        title = try container.decode(String.self, forKey: .title)
        isFamily = try container.decode(Int.self, forKey: .isFamily)
        isFriend = try container.decode(Int.self, forKey: .isFriend)
        isPublic = try container.decode(Int.self, forKey: .isPublic)
        
    }

    
}
