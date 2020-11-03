//
//  GameOver.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

import SwiftUI

//Menu to show when game ends
struct GameOver: View {
    @Binding var totalScore: Int
    @AppStorage("highScore", store: UserDefaults(suiteName: ContentView.appGroup)) var highScore: Int = 0
    @State private var topText: String = "Game Over"
    @State private var subText: String = "Score: "
    @Binding var gameOverShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white)
                VStack {
                    Text(topText)
                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                        .bold()
                        .foregroundColor(.black)
                    Text(subText + "\(totalScore)")
                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                        .scaledToFill()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    //Play again button navigates back to countdown view
                    NavigationLink(destination: Countdown()
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true), label: {
                                        Text("Play Again")
                                            .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                                            .padding()
                                    }
                    )
                    .buttonStyle(BorderlessButtonStyle())
                    .background(Color.green)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                    
                    //Main menu button navigates back to start view
                    NavigationLink(destination: StartView()
                                   , label: {
                                    Text("Main Menu")
                                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                                        .padding()
                                        .foregroundColor(.white)
                                   })
                        .buttonStyle(BorderlessButtonStyle())
                        .background(Color.gray)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .scaledToFit()
                }.scaledToFill()
            }.frame(minHeight: 150, idealHeight: 182, maxHeight: 200)
            .padding()
            Spacer()
            
        }
        .background(VisualEffectView(effect: UIBlurEffect(style: .dark))
        .edgesIgnoringSafeArea(.all))
        .onAppear{
            //When game ends, check if player beat high score, update saved high score in AppStorage, and display SSS message
            if totalScore >= highScore {
                highScore = totalScore
                topText = "Supreme Silverware Sorter!"
                subText = "NEW HIGH SCORE: "
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        GameOver(totalScore: .constant(0), gameOverShowing: .constant(true))
    }
}

