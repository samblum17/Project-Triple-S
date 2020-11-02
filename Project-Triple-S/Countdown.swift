//
//  Countdown.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

import SwiftUI

struct Countdown: View {
    @State var readyShowing = true
    @State var setShowing = false
    @State var sortShowing = false
    @State var showGame = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 20) {
                Spacer(minLength: 10)
                Text("Ready")
                    .font(Font.custom("Chalkboard", size: 80, relativeTo: .largeTitle))
                   
                if setShowing {
                    Text("Set")
                        .font(Font.custom("Chalkboard", size: 80, relativeTo: .largeTitle))
                        

                }
                if sortShowing {
                    Text("Sort!")
                        .font(Font.custom("Chalkboard", size: 80, relativeTo: .largeTitle))
                      
                }
                Spacer()
                NavigationLink(destination: SortingCenter().navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true), isActive: $showGame, label: { EmptyView() })
            }.scaledToFill()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.setShowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.sortShowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.9) {
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

