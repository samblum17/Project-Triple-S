//
//  Countdown.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

import SwiftUI

struct Countdown: View {
    @State private var seconds = 3
    @State private var countdown: [String] = ["Ready"]
    @State var readyShowing = true
    @State var setShowing = false
    @State var sortShowing = false
    @State var showGame = false
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Ready")
                    .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
                   
                if setShowing {
                    Text("Set")
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
                }
                if sortShowing {
                    Text("Sort!")
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
                }
                NavigationLink(destination: SortingCenter().navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true), isActive: $showGame, label: { EmptyView() })
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.setShowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.sortShowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                    self.showGame = true
                }
            }
        }.navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    //Helper for dynamic type on custom font
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
}


struct Coundown_Previews: PreviewProvider {
    static var previews: some View {
        Countdown()
    }
}

