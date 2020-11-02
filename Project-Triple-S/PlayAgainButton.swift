//
//  PlayAgainButton.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

import SwiftUI

struct PlayAgainButton: View {
    var action: (() -> Void)?
    @Binding var gameOverShowing: Bool

    var body: some View {
                Group {
                Button(action: {
                    self.action?()
                    gameOverShowing = false
                }) {
                    Text("Play Again")
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .body), relativeTo: .body))
                        .padding()
                }
                .buttonStyle(BorderlessButtonStyle())
                .background(Color.green)
                .clipShape(Capsule())
                .foregroundColor(Color.white)
            }
        }
    
    //Dynamic type on custom font
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
       return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    }


struct PlayAgainButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayAgainButton(gameOverShowing: .constant(true))
    }
}
