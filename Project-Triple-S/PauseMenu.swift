//
//  PauseMenu.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/31/20.
//

import SwiftUI

//Menu to display on tap of pause button
struct PauseMenu: View {
    @Binding var pauseShowing: Bool
    @Binding var timeRemaining: Int
    @Binding var gameTimer: GameTimer
    @AppStorage("survivorMode", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorMode: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white)
                VStack {
                    Text("Game Paused")
                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                        .bold()
                        .foregroundColor(Color.black)
                    
                    //Resume button will create a new timer of current time remaining
                    Button(action: {
                        gameTimer.instantiateTimer(timeRemaining: timeRemaining)
                        pauseShowing = false
                        playSound(sound: "sorting-track", type: ".wav", status: true)
                    }, label: {
                        Text("Resume")
                            .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title3), relativeTo: .title3))
                            .padding()
                    }).buttonStyle(BorderlessButtonStyle())
                    .background(Color.green)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                    .scaledToFit()
                    
                    //Restart button navigates back to countdown view
                    NavigationLink(destination: Countdown()
                                   , label: {
                                    Text("Restart")
                                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title3), relativeTo: .title3))
                                        .padding()
                                        .foregroundColor(.white)
                                   })
                        .buttonStyle(BorderlessButtonStyle())
                        .background(Color.red)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .scaledToFit()
                }
            }.frame(minHeight: 150, idealHeight: 182, maxHeight: 200)
            .padding()
            Spacer()
        }.background(VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .edgesIgnoringSafeArea(.all))
        
    }
}

//Blurred background view
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


struct PauseMenu_Previews: PreviewProvider {
    static var previews: some View {
        PauseMenu(pauseShowing: .constant(true), timeRemaining: .constant(17), gameTimer: .constant(GameTimer(gameOverShowing: .constant(false))))
    }
}
