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
    
    @Environment(\.horizontalSizeClass) var hClass
    @Environment(\.verticalSizeClass) var vClass
    
    @State var showAlbum = false
    @State var showArtist = false
    @State var albumDetails: Album?
    @State var artistDetails: Artist?
    
    var imageURL = ""
    var imagesURL: [URL] = [URL]()
    
    init() {
        networkManager = NetworkManager()
        networkManager.createArtistsDatabase()
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            GeometryReader { geo in
                Button( action: {
                    self.artistDetails = self.networkManager.artistsDB[0]
                    self.showArtist = true
                } ) {
                    ZStack(alignment: .bottom) {
                        
                        // ------ Big Image on the main screen starts here -----------------
                        
                        if self.networkManager.artistsDB.count > 0 {
                          
                            UrlImageView(urlString: self.networkManager.artistsDB[0].artistImage)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                        }
                        VStack(alignment: .center) {
                            Text("Featured artist")
                                .foregroundColor(.yellow)
                                .font(.custom("AvenirNext-Regular",size: 16))
                                .padding(.bottom, 8)
                            
                        if self.networkManager.artistsDB.count > 0 {
                            Text((self.networkManager.artistsDB[0].artistName)
                            .uppercased())
                            .foregroundColor(.white)
                            .font(.custom("AvenirNext-Bold", size:24))
                            }
                        }.frame(width: geo.size.width, height: 80)
                            .background(Color.black.opacity(0.5))
                    }
                }.sheet(isPresented: self.$showArtist) {
                    ArtistView(data: self.artistDetails!)
                }
            }.frame(height: hClass == .compact && vClass == .regular ? 400 : 600)
            
                  
            
                 // ------ Artist's albums scroll view starts here  -----------------
            
            VStack(alignment:.leading){
                if self.networkManager.artistsDB.count > 0 {
                    Text("Discover new albums of \(self.networkManager.artistsDB[0].artistName)")
                        .font(.custom("AvenirNext-Regular", size: 16))
                        .padding(.top,10)
                }
                ThumbScrollView(albumsData: self.networkManager.albumsDB.album)
            }.frame(minWidth: 0, maxWidth:.infinity,maxHeight: .infinity, alignment: .leading)
                .padding(.leading, 10)
            
            
            
                // ------ Various artists scrollview starts here  -----------------
           
            VStack(alignment:.leading){
                Text("Discover new artists")
                    .font(.custom("AvenirNext-Regular", size: 16))
                    .padding(.top,10)
                
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
                                        Text(data.artistName)
                                            .foregroundColor((.secondary))
                                            .font(.custom("AvenirNext-Regular", size: 14))
                                    }
                            }.sheet(isPresented: self.$showArtist) {
                                ArtistView(data: self.artistDetails!)
                            }
                        }
                    }.frame(height: 180)
                }
                }.frame(minWidth: 0, maxWidth:.infinity,maxHeight: .infinity, alignment: .leading)
                .padding(.leading, 10)
        }.edgesIgnoringSafeArea(.top)
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

