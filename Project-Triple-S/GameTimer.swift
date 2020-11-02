//
//  GameTimer.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/28/20.
//

import SwiftUI
import Combine

//Timer for game
struct GameTimer: View {
    @State var timeRemaining = 17
    @Binding var gameOverShowing: Bool
    @State private var isActive = true
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(timeRemaining)").bold()
            .onReceive(timer) { _ in
                guard self.isActive else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 01
                } else {
                    gameOverShowing = true
                }
            }
            .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
            .foregroundColor(timeRemaining > 10 ? .yellow : .red)
//            Stop timer when exiting app
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.isActive = true
            }
    }
    
    //Helper for dynamic type on custom font
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
       return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    //Restart timer
    mutating func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        self.timeRemaining = 17
        return
    }
    
    func cancelTimer() {
        self.timer.upstream.connect().cancel()
        return
    }
}

struct GameTimer_Previews: PreviewProvider {
    static var previews: some View {
        GameTimer(gameOverShowing: .constant(false))
    }
}
