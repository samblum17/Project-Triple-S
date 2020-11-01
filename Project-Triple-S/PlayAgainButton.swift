//
//  PlayAgainButton.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

import SwiftUI

struct PlayAgainButton: View {
    var action: (() -> Void)?

    var body: some View {
                Group {
                Button(action: {
                    self.action?()
                    //restart method
                }) {
                    Text("Play Again")
                        .font(.title3)
                        .padding()
                }
                .buttonStyle(BorderlessButtonStyle())
                .background(Color.green)
                .clipShape(Capsule())
                .foregroundColor(Color.white)
            }
        }
    }


struct PlayAgainButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayAgainButton()
    }
}
