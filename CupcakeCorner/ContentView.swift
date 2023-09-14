//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Oleg Gavashi on 14.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        OrderView()
            .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
