//
//  PlayAgainButton.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//


//DEPRECATED- PlayAgainButton is unnused (replaced with nav link). Keep for possible future implementation


//import SwiftUI

//struct PlayAgainButton: View {
//    var action: (() -> Void)?
//    @Binding var gameOverShowing: Bool
//
//    var body: some View {
//        NavigationView {
//            Group {
////                Progromatically navigate to game after showing countdown
//                NavigationLink(destination: Countdown()
//                                .navigationBarBackButtonHidden(true)
//                                .navigationBarHidden(true), label: {
//                                    Text("Play Again")
//                                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .body), relativeTo: .body))
//                                        .padding()
//                                }
//                )
//                .buttonStyle(BorderlessButtonStyle())
//                .background(Color.green)
//                .clipShape(Capsule())
//                .foregroundColor(Color.white)
//
//            }.navigationBarBackButtonHidden(true)
//            .navigationBarHidden(true)
//        }
//    }
//
//    //Dynamic type on custom font
//    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
//        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
//    }
//}
//
//
//struct PlayAgainButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayAgainButton(gameOverShowing: .constant(true))
//    }
//}
