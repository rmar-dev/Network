//
//  DetailsModel.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 13/10/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation

struct DetailsModel {
    let backdrop: String?
    let poster: String?
    let overview: String?
    let title: String
    let rating: Double
}

extension DetailsModel: Decodable{
    
    private enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case overview
        case title = "original_title"
        case rating = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        backdrop = try container.decode(String?.self, forKey: .backdrop)
        poster = try container.decode(String?.self, forKey: .poster)
        overview = try container.decode(String?.self, forKey: .overview)
        title = try container.decode(String.self, forKey: .title)
        rating = try container.decode(Double.self, forKey: .rating)

    }
}
