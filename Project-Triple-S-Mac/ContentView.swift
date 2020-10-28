//
//  ContentView.swift
//  Project-Triple-S-Mac
//
//  Created by Sam Blum on 10/28/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SortingCenter()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
