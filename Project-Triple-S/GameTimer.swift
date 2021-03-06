//
//  GameTimer.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/28/20.
//

import SwiftUI
import Combine

//Timer to manage gameplay
struct GameTimer: View {
    @AppStorage("survivorMode", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorMode: Bool = false
    @State var timeRemaining = 17
    @Binding var gameOverShowing: Bool
    @State private var isActive = true
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(survivorMode ? ":0\(timeRemaining)" : "\(timeRemaining)").bold()
            .onReceive(timer) {_ in
                guard self.isActive else { return }
                if self.timeRemaining > 0 {
                    //Remove visible countdown in survivor mode to avoid 0 bug with timer
                    if !survivorMode {
                        self.timeRemaining -= 01
                    }
                } else {
                    gameOverShowing = true
                }
            }
            .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
            .foregroundColor(timeRemaining > 10 ? .yellow : .red)
            //Pause timer when exiting app
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.isActive = true
            }
            .onAppear {
                if survivorMode {
                    timeRemaining = 1
                }
            }
    }
    
    //Helper function to restart timer
    mutating func instantiateTimer(timeRemaining: Int) {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        self.timeRemaining = timeRemaining
        return
    }
    
    //Helper function to cancel timer
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
