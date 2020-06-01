//
//  ImageFetcher.swift
//  MusBase
//
//  Created by Start on 23/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//


import Foundation
import Combine

class ImageFetcher: ObservableObject  {
    
   @Published var imageData: Data? = nil
    
    
    var imageURL: URL?
    
    public init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    func getImage() {
        
        guard let url = imageURL else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.imageData = data
               // print(self.imageData)
                
            }
        }.resume()
    }
}



