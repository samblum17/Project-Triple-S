//
//  SurvivorTimer.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/28/20.
//

import SwiftUI
import Combine

//Timer to manage gameplay
struct SurvivorTimer: View {
    @AppStorage("survivorMode", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorMode: Bool = false
    @State var timeRemaining = 1.0
    @Binding var gameOverShowing: Bool
    @State private var isActive = true
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(timeRemaining)").bold()
            .onReceive(timer) { _ in
                guard self.isActive else { return }
                if self.timeRemaining > 0.0 {
                    self.timeRemaining -= 0.1
                } else {
                    gameOverShowing = true
                }
            }
            .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
            .foregroundColor(.red)
            //Pause timer when exiting app
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.isActive = true
            }
            .onAppear {
                if survivorMode {
                    timeRemaining = 1.0
                }
            }
    }
    
    //Helper function to restart timer
    mutating func instantiateTimer(timeRemaining: Double) {
        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        self.timeRemaining = timeRemaining
        return
    }
    
    //Helper function to cancel timer
    func cancelTimer() {
        self.timer.upstream.connect().cancel()
        return
    }
}

struct SurvivorTimer_Previews: PreviewProvider {
    static var previews: some View {
        SurvivorTimer(gameOverShowing: .constant(false))
    }
}
