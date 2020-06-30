//
//  Extensions.swift
//  MusBase
//
//  Created by Start on 30/05/2020.
//  Copyright © 2020 Start. All rights reserved.
//

import Foundation
import SwiftUI

extension String {
  /*
   Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
   - Parameter length: Desired maximum lengths of a string
   - Parameter trailing: A 'String' that will be appended after the truncation.
    
   - Returns: 'String' object.
  */
  func trunc(length: Int, trailing: String = "…") -> String {
    return (self.count > length) ? self.prefix(length) + trailing : self
  }
}

extension Color {
    static let featuredArtistBackground = Color("featuredArtistBackground")
    static let albumViewBackground = Color("albumViewBackground")
    static let buttonFresh = Color("buttonFresh")
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

