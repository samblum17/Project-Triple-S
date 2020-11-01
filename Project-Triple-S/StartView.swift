//
//  StartView.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/28/20.
//

import SwiftUI

//Start screen
struct StartView: View {
    @AppStorage("highScore", store: UserDefaults(suiteName: ContentView.appGroup)) var highScore: Int = 0
    
    var body: some View {
        //Mainly visuals on this view, all inside of a navigation view/VStack
        NavigationView{
            VStack{
                Text("Silverware Sorter").font(Font.custom("Chalkboard", size: 33, relativeTo: .largeTitle)).bold()
                    .padding(.top)
                Image("angled-group")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("The dishes are ready.").font(Font.custom("Chalkboard", size: 25, relativeTo: .body))
                    .multilineTextAlignment(.center)
                Text("Are you?").font(Font.custom("Chalkboard", size: 25, relativeTo: .body))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Spacer()
                //Play button navigates to the Sorting Center- where all the magic happens.
                NavigationLink(
                    destination: SortingCenter(highScore: highScore)
                        //Remove unecessary spaces
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    ,
                    label: {
                        Image(systemName: "play.fill").resizable()
                            .frame(width: 50, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.init(UIColor.systemGray))
                            .shadow(radius: 10)
                            .padding()
                    })
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                Spacer()
                HStack{
                    Text("My All-Time High Score:").font(Font.custom("Chalkboard", size: 20, relativeTo: .body))
                    Text("\(highScore)").font(Font.custom("Chalkboard", size: 20, relativeTo: .body))
                }.padding()
                Spacer()
            }
            //Remove unecessary spaces
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
