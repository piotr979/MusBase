//
//  DataArrayFetcher.swift
//  MusBase
//
//  Created by Start on 30/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation
import Combine

class DataArrayFetcher: ObservableObject  {
    
    @Published var imageData: Data? = nil {
        didSet {
            print("Image data set")
        }
    }
     var imagesData: [Data] = [Data]()
    
    var imageURLs: [URL?]
    
    public init(imageURLs: [URL?]) {
        self.imageURLs = imageURLs
        for x in 0...imageURLs.count {
            fetchImages(loadFromURL: imageURLs[x]! )
        }
    }
    func fetchImages(loadFromURL: URL) {
        
    }
    
    func loadImage(imageURL: URL?, completion: @escaping (Data?) -> ()) {
        
        guard let url = imageURL else { return }
        
        URLSession.shared.dataTask(with: url)  { data,response,error in
        
print(error)
            
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.imageData = data
                print(self.imageData)
                
            }
        }.resume()
    }

}
