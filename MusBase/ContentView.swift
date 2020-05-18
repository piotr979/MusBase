//
//  ContentView.swift
//  MusBase
//
//  Created by Start on 17/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().isOpaque = true
        UITableView.appearance().backgroundColor = .clear
        //   print("Number is \(networkManager.spoonMainCourses.number)")
    }
    
    var body: some View {
        ZStack {
            Color.featuredArtistBackground.edgesIgnoringSafeArea(.all)
        VStack {
            
        GeometryReader { geometry in
              ScrollView(.vertical) {
                  VStack {
                    VStack(alignment: .leading) {
                        Text("Featured artist").bold().font(.system(size: 22)).padding(.bottom, 5)
                        Text("Explore famous artists and less known virtuosos").foregroundColor(.secondary).font(.system(size:12)).padding(.bottom, 10)
                         
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    
                          Image("cp")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width)  .shadow(color: .gray, radius: 5)
                    VStack(alignment: .leading) {
                      Text("Discover more - artists").bold().font(.system(size: 16))
                        ScrollView(.horizontal) {
                            Text("this is")
                        }
                      Text("Discover more - albums").bold().font(.system(size: 16))
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading).padding(.top, 20)
                    
                      Spacer()
                  }.padding(.top,10)
                
              }
              }.padding(.horizontal,20)
        }
    }
    }
}
struct BandImage: View {
    var body: some View {
       
      
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    .frame(width: geometry.size.width / 2)
                    Image("cp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 2)
                }
                Spacer()
            }

        }
        
    
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let featuredArtistBackground = Color("featuredArtistBackground")
}
