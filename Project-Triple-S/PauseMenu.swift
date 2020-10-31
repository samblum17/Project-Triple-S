//
//  PauseMenu.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/31/20.
//

import SwiftUI

struct PauseMenu: View {
    @Binding var pauseShowing: Bool
    
    var body: some View {
            VStack {
                Spacer()
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white)
                    VStack {
                        Text("Game Paused").font(.title).bold()
                        Button(action: {
                            pauseShowing = false
                        }, label: {
                            Text("Resume")
                                .font(.title3)
                                .padding()
                        }).buttonStyle(BorderlessButtonStyle())
                        .background(Color.green)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .scaledToFit()
                        RestartButton(pauseShowing: $pauseShowing)
                            .scaledToFit()
                    }
                }.frame(minHeight: 150, idealHeight: 182, maxHeight: 200)
                .padding()
                Spacer()

            }.background(VisualEffectView(effect: UIBlurEffect(style: .dark))
            .edgesIgnoringSafeArea(.all))
}
}

struct PauseMenu_Previews: PreviewProvider {
    static var previews: some View {
        PauseMenu(pauseShowing: .constant(true))
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
