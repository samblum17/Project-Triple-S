//
//  Help.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/6/20.
//

import SwiftUI

//Help view for more info on game modes and user scores from StartView
struct Help: View {
    @Environment(\.presentationMode) private var presentationMode
    @AppStorage("highScore", store: UserDefaults(suiteName: ContentView.appGroup)) var highScore: Int = 0
    @AppStorage("survivorHighScore", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorHighScore: Int = 0
    @AppStorage("allTimeSortedUtensils", store: UserDefaults(suiteName: ContentView.appGroup)) var allTimeSortedUtensils: Int = 0
    
    var body: some View {
        ScrollView{
            VStack {
                VStack{
                    Text("Classic Mode").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("High Score: \(highScore)").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                        .multilineTextAlignment(.center)
                    HStack() {
                        Text("How quickly can you sort? You only have 17 seconds to sort as many utensils as possible.").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                    }.padding()
                    .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                
                Divider()
                
                VStack{
                    Text("Survivor Mode").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("High Score: \(survivorHighScore)").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                        .multilineTextAlignment(.center)
                    HStack() {
                        Text("How many utensils can you correctly sort in a row? Keep sorting without misplacing one to survive. You only have 1 second to sort each utensil.").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                    }.padding()
                    .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                
                Divider()
                
                HStack {
                    //Show all time score but if it is less than current high score (pre version 2.0 users), show high score + all time instead
                    Text("You've sorted an all-time total of\n\(allTimeSortedUtensils < highScore ? (allTimeSortedUtensils + highScore) : allTimeSortedUtensils) utensils!").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title2), relativeTo: .title2))
                        .bold()
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                }.fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help().environment(\.sizeCategory, .large)
    }
}
