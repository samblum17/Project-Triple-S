//
//  RestartButton.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/30/20.
//

import SwiftUI

struct RestartButton: View {
    @Binding var pauseShowing: Bool
    
    var action: (() -> Void)?
    
    var body: some View {
        Group {
            Button(action: {
                self.action?()
                pauseShowing = false
            }) {
                Text("Start Over")
                    .font(.title3)
                    .padding()
            }
            .buttonStyle(BorderlessButtonStyle())
            .background(Color.red)
            .clipShape(Capsule())
            .foregroundColor(Color.white)
        }
    }
}

struct RestartButton_Previews: PreviewProvider {
    static var previews: some View {
        RestartButton(pauseShowing: .constant(false))
    }
}
