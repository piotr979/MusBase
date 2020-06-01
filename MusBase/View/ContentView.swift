//
//  ContentView.swift
//  MusBase
//
//  Created by Start on 17/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager: NetworkManager
 //   @ObservedObject var networkAlbums: NetworkAlbums
    @Environment(\.horizontalSizeClass) var hClass
    @Environment(\.verticalSizeClass) var vClass
   // @Environment(\.imageCache) var cache: ImageCache
    @State var showAlbum = false
    @State var showArtist = false
    
    
    
    var imageURL = ""
    var imagesURL: [URL] = [URL]()
    @State var albumDetails: Album?
    @State var artistDetails: Artist?
    
    init() {
        networkManager = NetworkManager()
      //  networkAlbums = NetworkAlbums()
        networkManager.createArtistsDatabase()
          //networkAlbums.findAlbums()
        
        
        
    }
    var body: some View {
        
        ScrollView(.vertical) {
         
            GeometryReader { geo in

                Button( action: {} ) {
                    ZStack(alignment: .bottom) {

                        if self.networkManager.artistsDB.count > 0 {
                            
                           UrlImageView(urlString: self.networkManager.artistsDB[0].artistImage) .aspectRatio(contentMode: .fill)
                               .frame(width: geo.size.width, height: geo.size.height)
                               .clipped()
                        }


                        VStack(alignment: .center) {
                            Text("Featured artist").foregroundColor(.yellow).font(.custom("AvenirNext-Regular",size: 16)).padding(.bottom, 8)

                            if self.networkManager.artistsDB.count > 0 { Text((self.networkManager.artistsDB[0].artistName).uppercased()).foregroundColor(.white).font(.custom("AvenirNext-Bold", size:24))
                            }
                        }.frame(width: geo.size.width, height: 80).background(Color.black.opacity(0.5))
                    }
                }
            }.frame(height: hClass == .compact && vClass == .regular ? 400 : 600)

            VStack(alignment:.leading){
                if self.networkManager.artistsDB.count > 0 {
                    Text("Discover new albums of \(self.networkManager.artistsDB[0].artistName)").font(.custom("AvenirNext-Regular", size: 16)).padding(.top,10)
                }
                
                ThumbScrollView(albumsData: self.networkManager.albumsDB.album)
         


            }.frame(minWidth: 0, maxWidth:.infinity,maxHeight: .infinity, alignment: .leading).padding(.leading, 10)

            VStack(alignment:.leading){
                Text("Discover new artists").font(.custom("AvenirNext-Regular", size: 16)).padding(.top,10)


                ScrollView(.horizontal) {
                    HStack {


                        ForEach(self.networkManager.artistsDB, id:\.self) { data in

                            Button(action:{
                                self.artistDetails = data
                                self.showArtist = true } ) {
                                    VStack {
                                       
                                  
                                            UrlImageView(urlString: data.artistImage)
                                          .frame(width: 150, height: 150)
                                          .cornerRadius(10)
                                      
                                        Text(data.artistName).foregroundColor((.secondary)).font(.custom("AvenirNext-Regular", size: 14))
                                    }
                            }.sheet(isPresented: self.$showArtist) {
                                Text(self.artistDetails!.artistName)
                            }
                        }

                    }.frame(height: 180)
                }


            }.frame(minWidth: 0, maxWidth:.infinity,maxHeight: .infinity, alignment: .leading).padding(.leading, 10)
        }.edgesIgnoringSafeArea(.top)
    }
}
struct AlbumDetails: View {
    var data: Album

    init(data: Album) {
        self.data = data
        //print(data)
    }
    var body: some View {

        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                   if self.data.strAlbumThumb == nil || self.data.strAlbumThumb!.isEmpty {
                    Image("musPlaceholder").resizable().aspectRatio(contentMode: .fill).frame(width: geo.size.width)
                                         } else {
                    UrlImageView(urlString: self.data.strAlbumThumb!).aspectRatio(contentMode: .fit).frame(width: geo.size.width)
                                             .clipped()
                                          }
                }.edgesIgnoringSafeArea(.top)
                VStack {
                    
                    //.frame(width:geo.size.width / 2 ).padding(.top,20).shadow(color: .gray, radius: 6, x: 3, y: 3).shadow(color: .gray, radius: 6, x: -3, y: -3)

                    if self.data.strAlbum != nil {
                        Text(self.data.strAlbum!.uppercased()).bold().font(.custom("AvenirNext-Regular", size: 24)).multilineTextAlignment(.center).padding(.bottom, 10)
                    }
                      if self.data.strArtist != nil {
                    Text(self.data.strArtist!.uppercased()).font(.system(size: 24)).padding(.bottom,10).multilineTextAlignment(.center)
                    }
                      if self.data.intYearReleased != nil {
                        Text(self.data.intYearReleased!).font(.subheadline).padding(.bottom,10)
                    }
                      if self.data.strGenre != nil {
                   Text("Genre: \(self.data.strGenre!)").padding(.bottom,10)
                    }
                    if self.data.strLabel != nil {
                        Text("Released by: \(self.data.strLabel!)").padding(.bottom,10)
                        }
                   
                    if self.data.intScore != nil {
                        Text("Scores \(self.data.intScore!)").padding(.bottom,20)
                                                              }
                    if self.data.strDescriptionEN != nil {
                         
                      Text(self.data.strDescriptionEN!)
                    Spacer()
                    }
                    
                   
                }.padding()
            }
        }
    }
}

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .renderingMode(.original)
            .resizable()
            
        
            
    }
    
    static var defaultImage = UIImage(named: "musPlaceholder")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let featuredArtistBackground = Color("featuredArtistBackground")
}
