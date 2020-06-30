//
//  Artist.swift
//  MusBase
//
//  Created by Start on 18/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation

struct ArtistsBase: Codable,Hashable {
    var artists: [Artist]
}
struct Artist: Codable, Hashable {
    var idArtist: String = ""
    var strLabel: String = ""
    var strGenre: String = ""
    var artistName: String = ""
    var artistImage: String = ""
    var members: String = ""
    var country: String = ""
    var yearFormed: String = ""
    var strWebsite: String = ""
    var strBiographyEN: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case idArtist = "idArtist"
        case strLabel = "strLabel"
        case strGenre = "strGenre"
        case artistName = "strArtist"
        case artistImage = "strArtistThumb"
        case members = "intMembers"
        case country = "strCountry"
        case yearFormed = "intFormedYear"
        case strWebsite = "strWebsite"
        case strBiographyEN = "strBiographyEN"
    }
    
  init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
           idArtist = try container.decode(String.self, forKey: .idArtist)
           
           if try container.decodeNil(forKey: .strLabel) {
               strLabel = ""
           } else {
               let string = try container.decode(String.self, forKey: .strLabel)
           }
          // strLabel = (try container.decode(String.self, forKey: .strLabel)) ?? "unknown"
           strGenre = try container.decode(String.self, forKey: .strGenre)
           artistName = try container.decode(String.self, forKey: .artistName)
           artistImage = try container.decode(String.self, forKey: .artistImage)
    country = try container.decode(String.self, forKey: .country)
           members = try container.decode(String.self, forKey: .members)
        yearFormed = try container.decode(String.self, forKey: .yearFormed)
    strWebsite = try container.decode(String.self, forKey: .strWebsite)
   strBiographyEN = try container.decode(String.self, forKey: .strBiographyEN)
       }
    
    
}
