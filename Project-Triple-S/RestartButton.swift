//
//  RestartButton.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/30/20.
//

import SwiftUI

struct RestartButton: View {
    var action: (() -> Void)?
    
    var body: some View {
        Group {
            Button(action: {
                self.action?()
            }) {
                Text("Reset Game")
                    .font(.title2)
                    .padding()
            }
            .buttonStyle(BorderlessButtonStyle())
            .background(Color.red)
            .clipShape(Capsule())
            .foregroundColor(Color.secondary)
        }
    }
}

struct RestartButton_Previews: PreviewProvider {
    static var previews: some View {
        RestartButton()
    }
}
