//
//  Countdown.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/1/20.
//

import SwiftUI

struct Countdown: View {
    //Variables to manage state of countdown
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
                
                //Progromatically navigate to game after showing countdown
                NavigationLink(destination: SortingCenter().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $showGame, label: { EmptyView()})
            }.scaledToFill()
            
            //Delay showing of "set" and "sort" to create a countdown effect
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    self.setShowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    self.sortShowing = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                    self.showGame = true
                }
            }
        }.navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}


struct Coundown_Previews: PreviewProvider {
    static var previews: some View {
        Countdown()
    }
}

