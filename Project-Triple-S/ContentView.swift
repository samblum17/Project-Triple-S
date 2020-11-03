//
//  ContentView.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//Main content view to enter from
struct ContentView: View {
    //Store high score in UserDefaults and access across app
    static let appGroup = "group.project-triple-s.shared-highScore"
    @AppStorage("highScore", store: UserDefaults(suiteName: appGroup)) var highScore: Int = 0
    
    var body: some View {
        StartView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
