//
//  PauseMenu.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/31/20.
//

import SwiftUI

//Menu to display on tap of pause button
struct PauseMenu: View {
    @Binding var pauseShowing: Bool
    @Binding var timeRemaining: Int
    @Binding var gameTimer: GameTimer
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white)
                VStack {
                    Text("Game Paused")
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title)).bold()
                        .foregroundColor(Color.black)
                    //Resume will create a new timer of current time remaining
                    Button(action: {
                        gameTimer.instantiateTimer(timeRemaining: timeRemaining)
                        pauseShowing = false
                    }, label: {
                        Text("Resume")
                            .font(Font.custom("Chalkboard", size: textSize(textStyle: .title3), relativeTo: .title3))
                            .padding()
                    }).buttonStyle(BorderlessButtonStyle())
                    .background(Color.green)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                    .scaledToFit()
                    NavigationLink(destination: Countdown()
                                   , label: {
                                    Text("Restart")
                                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .title3), relativeTo: .title3))
                                        .padding()
                                        .foregroundColor(.white)
                                   })
                        .buttonStyle(BorderlessButtonStyle())
                        .background(Color.red)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .scaledToFit()
                }
            }.frame(minHeight: 150, idealHeight: 182, maxHeight: 200)
            .padding()
            Spacer()
            
        }.background(VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .edgesIgnoringSafeArea(.all))
        
    }
    //Helper for dynamic type on custom font
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
}

struct PauseMenu_Previews: PreviewProvider {
    static var previews: some View {
        PauseMenu(pauseShowing: .constant(true), timeRemaining: .constant(17), gameTimer: .constant(GameTimer(gameOverShowing: .constant(false))))
    }
}

//Blur background
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
