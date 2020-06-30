//
//  AlbumDetails.swift
//  MusBase
//
//  Created by Start on 31/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation
import SwiftUI

struct AlbumDetails: View {
    var data: Album
    var moreAboutArtist: Bool
    @State var isAboutArtistPresented = false
    init(data: Album, moreAboutArtist: Bool) {
        self.data = data
        self.moreAboutArtist = moreAboutArtist
    }
    var body: some View {
        
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                ZStack(alignment: .bottom) {
                    if self.data.strAlbumThumb == nil || self.data.strAlbumThumb!.isEmpty {
                        Image("musPlaceholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width)
                    } else {
                        UrlImageView(urlString: self.data.strAlbumThumb!)
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
                
                VStack {
                    if self.data.strAlbum != nil {
                        Text(self.data.strAlbum!.uppercased())
                            .font(.custom("AvenirNext-Bold", size: 24))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }
                    
                    if self.data.strArtist != nil {
                        Text(self.data.strArtist!.uppercased())
                            .foregroundColor(.secondary)
                            .font(.custom("AvenirNext-Demibold",size: 20))
                            .padding(.bottom,10)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack {
                        DetailsRow(rowText: "Year released", rowData: self.data.intYearReleased).padding(.top)
                        DetailsRow(rowText: "Label", rowData: self.data.strLabel)
                        DetailsRow(rowText: "Genre", rowData: self.data.strGenre)
                        DetailsRow(rowText: "Mood", rowData: self.data.strMood)
                        
                        if self.data.intScore != nil {
                            ScoreInfo(score: Float(self.data.intScore!)!)
                        }
                    }.background(Color.white)
                        .cornerRadius(17)
                        .padding(.vertical)
                    
                    if self.moreAboutArtist == true {
                        Button( action: { self.isAboutArtistPresented = true }) {
                            VStack {
                                Text("Find this artist".uppercased())
                                    .font(.custom("AvenirNext-Demibold", size: 20))
                                    .foregroundColor(.white)
                            }.frame(width: 300)
                                .padding(.vertical,13)
                                .background(Color.buttonFresh)
                                .cornerRadius(17)
                        }.buttonStyle(FreshButtonStyle())
                            .sheet(isPresented: self.$isAboutArtistPresented ) {
                            Text("Second modal view over the first one is presented")
                        }
                    }
                    
                    VStack {
                        if self.data.strDescriptionEN != nil {
                            Text("About album")
                                .font(.custom("AvenirNext", size: 14))
                                .padding(.vertical, 10)
                            Text(self.data.strDescriptionEN!)
                                .font(.custom("AvenirNext", size: 14))
                                .lineSpacing(4)
                                .padding()
                        }
                    }.frame(minHeight: 0, maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(17).font(.custom("AvenirNext", size: 16))
                        .padding(.top, 20)
                }.padding().offset(y: -30)
            }
        }.background(Color.albumViewBackground)
    }
}
struct FreshButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .shadow(color: .white, radius: 4, x: -1, y: -2)
            .shadow(color: .gray, radius: 4, x: 0, y: 1)
    }
}

struct DetailsRow: View {
    
    let rowText: String
    let rowData: String?
    
    var body: some View {
        VStack {
            
            HStack {
                Text(rowText)
                Spacer()
                if rowData != nil  {
                    Text(rowData!)
                        .textStyle(TableNameStyle())
                        .foregroundColor(.secondary)
                } else {
                    Text("N/A")
                        .textStyle(TableNameStyle())
                        .foregroundColor(.secondary)
                }
                }.padding(.leading).padding(.trailing)
            Divider()
        }
    }
}
struct ScoreInfo: View {
    
    var score: Int
    
    init(score: Float) {
        self.score = Int(score)
      }
    
    var body: some View {
        VStack(alignment: .center) {
            if score != nil {
                Text("\(score) of 10")
                    .textStyle(TableNameStyle())
                    .foregroundColor(.secondary)
                HStack {
                    ForEach(0..<score, id:\.self) { _ in
                        Image(systemName: "star.circle")
                            .foregroundColor(.red)
                    }
                }.padding(.bottom)
            }
            
        }
    }
}
