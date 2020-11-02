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
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
                        .bold()
                        .foregroundColor(.black)
                    Text(subText + "\(totalScore)")
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .body), relativeTo: .body))
                        .scaledToFill()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    PlayAgainButton(gameOverShowing: $gameOverShowing)
                    NavigationLink(destination: StartView()
                                   , label: {
                                    Text("Main Menu")
                                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .body), relativeTo: .body))
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
            if totalScore >= highScore {
                highScore = totalScore
                topText = "Supreme Silverware Sorter!"
                subText = "You sorted a whopping high score: "
            }
        }
        
    }
    //Helper for dynamic type on custom font
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        GameOver(totalScore: .constant(0), gameOverShowing: .constant(true))
    }
}

