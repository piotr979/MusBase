//
//  Styles.swift
//  MusBase
//
//  Created by Start on 04/06/2020.
//  Copyright © 2020 Start. All rights reserved.
//


import SwiftUI

struct TableNameStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.custom("AvenirNext-Medium", size: 14))
    }
}
