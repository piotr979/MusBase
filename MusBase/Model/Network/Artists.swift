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
    var strStyle: String = ""
    var artistName: String = ""
    var artistImage: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case idArtist = "idArtist"
        case strLabel = "strLabel"
        case strStyle = "strStyle"
        case artistName = "strArtist"
        case artistImage = "strArtistThumb"
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
        strStyle = try container.decode(String.self, forKey: .strStyle)
        artistName = try container.decode(String.self, forKey: .artistName)
        artistImage = try container.decode(String.self, forKey: .artistImage)
        
    }
    
    
}
