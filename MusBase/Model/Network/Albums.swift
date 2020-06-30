//
//  Albums.swift
//  MusBase
//
//  Created by Start on 24/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation

struct Albums: Codable, Hashable {
    var album: [Album]
}

struct Album: Codable, Hashable {
   var idAlbum: String
   var idArtist: String
  var strAlbum: String?
    var strArtist: String?
    var strGenre: String?
    var strLabel: String?
    var intSales: String?
    var intScore: String?
    var strMood: String?
   var intYearReleased: String?
    var strAlbumThumb: String?
   var strDescriptionEN: String?
    
  
}
