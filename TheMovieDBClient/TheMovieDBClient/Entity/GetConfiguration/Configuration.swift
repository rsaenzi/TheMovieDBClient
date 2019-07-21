//
//  Configuration.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/21/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

struct Configuration: Codable {
    
    let changeKeys: [String]
    let images: ConfigurationItem
    
    enum CodingKeys: String, CodingKey {
        case changeKeys = "change_keys"
        case images = "images"
    }
}
