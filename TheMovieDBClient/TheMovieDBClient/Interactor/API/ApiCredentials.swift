//
//  ApiCredentials.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/21/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UAObfuscatedString

class ApiCredentials {

    // For security reasons, apiKey and apiUrl are obfuscated
    static var apiURL: String = "".h.t.t.p.s.colon.forward_slash.forward_slash.a.p.i.dot.t.h.e.m.o.v.i.e.d.b.dot.o.r.g.forward_slash._3
    
    static var apiKey: String = "".a.e._7._9._4._7._4.b.f._1._6.e._5.c.a.b._7._5._9.a._3.f._4.f._0._7._8.a._4.f._5.e
    
    static let imdbUrl = "https://m.imdb.com/title/"
    
    
    // "To build an image URL, you will need 3 pieces of data. The base_url, size and file_path"
    // https://developers.themoviedb.org/3/configuration/get-api-configuration
    static var imageBaseUrl: String? = nil
    static var imageBackdropSize: String? = nil
    static var imageLogoSize: String? = nil
    static var imagePosterSize: String? = nil
    static var imageProfileSize: String? = nil
    static var imageStillSize: String? = nil
}
