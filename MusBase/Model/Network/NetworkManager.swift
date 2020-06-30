//
//  NetworkManager.swift
//  MusBase
//
//  Created by Start on 18/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var artistsDB = [Artist]()
    @Published var albumsDB = Albums(album: [])
    
    var artistsDBTemp = [Artist]() {
        willSet {
            if newValue.count == 10 {
                artistsDB = newValue
                findAlbums(artistName: artistsDB[0].artistName)
                //  print(newValue)
            }
        }
    }
    var indexArtist = 0
    var collectedArtists = 0
   
    // this function is recursive
    func createArtistsDatabase() {
        findArtistBy(id: String(111250 + Int.random(in: 1...200))) { status in
            self.indexArtist += 1
            if status == true {
                self.collectedArtists += 1
                if self.collectedArtists == 10 {
                    //     self.findAlbums()
                    return }
                self.createArtistsDatabase()
            } else {
                self.createArtistsDatabase()
                print("not done")
            }
        }
    }
    
    func findAlbums(artistName: String) {
        var url: URL
        //    print(artistsDB[0].artistName)
        guard let urlName = URL.getAlbumsByArtistName(name: artistName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)) else { return }
        //    guard let urlName = URL.getAlbumsByArtistName(name: "Dr.%20Dre") else { return }
        url = urlName
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data,response,error in
            print(data)
            print(response)
            print(error)
            if error != nil || data == nil {
                print("Client error")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error")
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong mime type")
                return
            }
            guard let dataToDecode = data else { return }
            do {
                let decoder = JSONDecoder()
                
                let dataJSONed = try decoder.decode(Albums.self, from: dataToDecode)
                DispatchQueue.main.async {
                    // print("Finding albums")
                    self.albumsDB = dataJSONed
                    
                  
                }
            } catch {
                print("Error while decoding!")
            }
        }
        task.resume()
    }
    func findArtistBy(id: String = "111251", name: String = "", success: @escaping (Bool) -> ()) {
        
        var url: URL
        
        if id != "" {
            guard let urlID = URL.getArtistByID(id: String(id)) else { return }
            url = urlID
            
        } else {
            guard let urlName = URL.getArtistByName(name: name) else { return }
            url = urlName
            
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data,response,error in
            
            if error != nil || data == nil {
                print("Client error")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error")
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong mime type")
                return
            }
            
            guard let dataToDecode = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let dataJSONed = try decoder.decode(ArtistsBase.self, from: dataToDecode)
                DispatchQueue.main.async {
                    
                    self.artistsDBTemp.append(dataJSONed.artists[0])
                    
                    //  if self.indexAlbum == 10 {
                    //       self.artistsDB = self.artistsDBTemp
                    //   }
                    // }
                    print("appending")
                    success(true)
                    
                    
                }
            } catch {
                print("Error while decoding!")
                success(false)
            }
            
        }
        task.resume()
    }
}

extension URL {
    static func getArtistByID(id: String) -> URL? {
        return URL(string: "https://theaudiodb.com/api/v1/json/1/artist.php?i=\((id))")
    }
    static func getArtistByName(name: String) ->URL? {
        print("https://www.theaudiodb.com/api/v1/json/1/search.php?s=\(name)")
        return URL(string: "https://www.theaudiodb.com/api/v1/json/1/search.php?s=\(name)")
    }
    static func getAlbumsByArtistName(name: String) ->URL? {
        return URL(string: "https://theaudiodb.com/api/v1/json/1/searchalbum.php?s=\(name)")
    }
}
