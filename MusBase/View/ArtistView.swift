//
//  ArtistView.swift
//  MusBase
//
//  Created by Start on 04/06/2020.
//  Copyright © 2020 Start. All rights reserved.
//
// This struct is responsible for Artist view (photos, details, albums, etc.)
// Contains also Album list which is a part of ArtistView struct


import Foundation
import SwiftUI

struct ArtistView: View {
    
    var data: Artist
    
    @ObservedObject var artistNetManager: NetworkManager
    
    init(data: Artist) {
        self.data = data
        artistNetManager = NetworkManager()
        artistNetManager.findAlbums(artistName: data.artistName)
        self.data = data
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                // -------------- Image of the artist starts here ---------------
                ZStack(alignment: .bottom) {
                    
                    if self.data.artistImage == nil || self.data.artistImage.isEmpty {
                        Image("musPlaceholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width)
                    } else {
                        UrlImageView(urlString: self.data.artistImage)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width)
                            .clipped()
                    }
                    VStack {
                        Rectangle()
                            .rotation(.degrees(180))
                            .fill(Color.albumViewBackground)
                            .background(Color.albumViewBackground)
                            .frame(width: geo.size.width, height: 120)
                            .offset(x:0, y:-60)
                            .cornerRadius(40)
                        
                    }.offset(y:80)
                }.edgesIgnoringSafeArea(.top)
                
                
                // ------------Name of the artist starts here  ---------------------------
                VStack {
                    
                    if self.data.artistName != nil {
                        Text(self.data.artistName.uppercased())
                            .font(.custom("AvenirNext-Bold", size: 24))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                    
                
                // ------------Details  of the artist starts here  ---------------------------
                    
                    VStack {
                        
                        DetailsRow(rowText: Int(self.data.members) != 1 ? "Year formed" : "Active from" , rowData: self.data.yearFormed).padding(.top)
                        DetailsRow(rowText: "City / Country", rowData: self.data.country)
                        DetailsRow(rowText: "Genre", rowData: self.data.strGenre)
                        DetailsRow(rowText: "Members", rowData: self.data.members)
                        DetailsRow(rowText: "Website", rowData: self.data.strWebsite)
                    }.background(Color.white)
                        .cornerRadius(17)
                        .padding(.top)
                    VStack {
                        Text("Albums")
                            .font(.custom("AvenirNext", size: 14))
                            .padding(.vertical, 10)
                        AlbumsList(data: self.artistNetManager.albumsDB.album)
                    }.background(Color.white)
                        .cornerRadius(17)
                        .padding(.top, 20)
                    }.padding().offset(y: -30)
            }
        }.background(Color.albumViewBackground)
    }
}


struct AlbumsList: View {
    
    var data: [Album]
    
    @State var isPresented = false
    @State var albumDetails: Album?
    var body: some View {
        
        List(data, id:\.self) { data in
            Button(action: { self.isPresented = true
                self.albumDetails = data
            }) {
                HStack {
                    VStack {
                        if data.strAlbumThumb == nil || data.strAlbumThumb!.isEmpty {
                            Image("musPlaceholder")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            UrlImageView(urlString: data.strAlbumThumb!)
                        }
                    }.frame(width: 100, height: 100).cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text("\(data.strArtist!)")
                            .textStyle(TableNameStyle())
                            .padding(.bottom, 10)
                        
                        if data.intYearReleased != nil  {
                            Text(data.intYearReleased!)
                                .textStyle(TableNameStyle())
                                .foregroundColor(.secondary)
                        }
                        Spacer()
//                                        if data.strLabel != nil  {
//                                            Text(data.strLabel!).font(.custom("AvenirNext-Medium", size: 14)).foregroundColor(.secondary)
//                                        }
                    }
                }
            }.sheet(isPresented: self.$isPresented) {
                AlbumDetails(data: self.albumDetails!, moreAboutArtist: false)
            }
        }.frame(height: 1200)
    }
}




