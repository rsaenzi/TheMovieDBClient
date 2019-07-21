//
//  SpokenLanguage.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/21/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

struct SpokenLanguage: Codable {
    
    let iso6391: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name = "name"
    }
}
