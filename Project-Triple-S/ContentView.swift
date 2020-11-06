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
    @AppStorage("survivorMode", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorMode: Bool = false
    @AppStorage("survivorHighScore", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorHighScore: Int = 0
    
    var body: some View {
        StartView()
    }
    
    //Helper funtion for dynamic type on custom font
    static func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
