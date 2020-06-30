//
//  ThumbScrollView.swift
//  MusBase
//
//  Created by Start on 31/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation
import SwiftUI

struct ThumbScrollView: View {
    
    var albumsData: [Album]
    
   
    @State private var showAlbum: Bool = false
    @State var albumDetails: Album?
       
    var body: some View {
        ScrollView(.horizontal) {
              HStack {


                          ForEach(albumsData, id:\.self) { data in

                              Button(action: {
                                  self.albumDetails = data
                                  self.showAlbum = true } ) {
                                      VStack {
                                          VStack {
                                              if data.strAlbumThumb == nil || data.strAlbumThumb!.isEmpty {
                                                  Image("musPlaceholder").renderingMode(.original).resizable().aspectRatio(contentMode: .fill)
                                                                     } else {
                                               
                                                  UrlImageView(urlString: data.strAlbumThumb!)
                                              }
                                          }.frame(width: 150, height: 150).cornerRadius(10)
                                          Text(data.strAlbum!.trunc(length: 21)).foregroundColor((.secondary)).font(.custom("AvenirNext-Regular", size: 14))
                                      }
                              }.sheet(isPresented: self.$showAlbum) {
                                  AlbumDetails(data: self.albumDetails!, moreAboutArtist: true)
                              }
                          }

                      }.frame(height: 180)
    }
    }
}
