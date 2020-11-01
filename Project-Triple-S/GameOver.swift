//
//  GameOver.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

import SwiftUI

struct GameOver: View {
    @Binding var totalScore: Int
    @AppStorage("highScore", store: UserDefaults(suiteName: ContentView.appGroup)) var highScore: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white)
                VStack {
                    if totalScore > highScore {
                        Text("Supreme Silverware Sorter!").font(.title).bold().foregroundColor(Color.black)
                        Text("You sorted a whopping high score: \(totalScore) utensils!").scaledToFill().multilineTextAlignment(.center)
                    } else {
                        Text("Game Over").font(.title).bold().foregroundColor(Color.black)
                        Text("Score: \(totalScore)")
                    }
                    PlayAgainButton()
                    NavigationLink(destination: StartView()
                                   , label: {
                                    Text("Main Menu")
                                        .font(.title3)
                                        .padding()
                                        .foregroundColor(.white)
                                   }).buttonStyle(BorderlessButtonStyle())
                        .background(Color.gray)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .scaledToFit()
                }.scaledToFill()
            }.frame(minHeight: 150, idealHeight: 182, maxHeight: 200)
            .padding()
            Spacer()
            
        }.background(VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .edgesIgnoringSafeArea(.all))
        .onAppear{
            if totalScore > highScore {
                highScore = totalScore
            }
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        GameOver(totalScore: .constant(1))
    }
}

