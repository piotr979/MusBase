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
  var strAlbum: String
    var strArtist: String
   var intYearReleased: String
    var strAlbumThumb: String = ""
 //  var strDescriptionEN: String = ""
    
    
    private enum CodingKeys2: String, CodingKey {

       case idAlbum = "idAlbum"
       case idArtist = "idArtist"
       case strAlbum = "strAlbum"
     case strArtist = "strArtist"
       case intYearReleased = "intYearReleased"
        case strAlbumThumb = "strAlbumThumb"
  //      case strDescriptionEN = "strDescriptionEN"

    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys2.self)

       idAlbum = try container.decode(String.self, forKey: .idAlbum)
        idArtist = try container.decode(String.self, forKey: .idArtist)
        strAlbum = try container.decode(String.self, forKey: .strAlbum)
        strArtist = try container.decode(String.self, forKey: .strArtist)
intYearReleased = try container.decode(String.self, forKey: .intYearReleased)
//
        
        if try container.decodeNil(forKey: .strAlbumThumb) {
            strAlbumThumb = "default"
        } else {
            strAlbumThumb = try container.decode(String.self, forKey: .strAlbumThumb)
        }
       // strAlbumThumb = try container.decode(String.self, forKey: .strAlbumThumb)
//       strDescriptionEN = try container.decode(String.self, forKey: .strDescriptionEN)

    }
    
}
