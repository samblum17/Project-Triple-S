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
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        var body: some View {
            Text("\(timeRemaining)")
                .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                }
                .font(.title)
                .foregroundColor(.yellow)
        }
    }

struct GameTimer_Previews: PreviewProvider {
    static var previews: some View {
        GameTimer()
    }
}
