//
//  GameTimer.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/28/20.
//

import SwiftUI

//Timer for game
struct GameTimer: View {
    @State var timeRemaining = 17
    @Binding var gameOverShowing: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(timeRemaining)").bold()
            .onReceive(timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 01
                } else {
                    gameOverShowing = true
                }
            }
            .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
            .foregroundColor(.yellow)
    }
    //Helper for dynamic type on custom font
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
       return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
}

struct GameTimer_Previews: PreviewProvider {
    static var previews: some View {
        GameTimer(gameOverShowing: .constant(false))
    }
}
