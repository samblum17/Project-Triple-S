//
//  Help.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/6/20.
//

import SwiftUI

struct Help: View {
    @Environment(\.presentationMode) private var presentationMode
    @AppStorage("highScore", store: UserDefaults(suiteName: ContentView.appGroup)) var highScore: Int = 0
    @AppStorage("survivorHighScore", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorHighScore: Int = 0

    var body: some View {
        VStack {
            VStack{
                Text("Classic Mode").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.leading)
                Text("My High Score: \(highScore)").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                    .multilineTextAlignment(.leading)
                HStack() {
                    Text("Race against the timer.  You have 17 seconds to sort as many utensils as possible.").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                }.padding()
                Spacer()
            }
            
        Divider()
            VStack{
                Text("Survivor Mode").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.center)
                Text("My High Score: \(survivorHighScore)").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                    .multilineTextAlignment(.center)
                HStack() {
                    Text("Race against yourself.  Keep sorting as many utensils as possible without misplacing one. You have 2 seconds to sort each utensil.").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                }.padding()
                Spacer()
                
            }
        }
        
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
