//
//  StartView.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/28/20.
//

import SwiftUI

//Start screen
struct StartView: View {
    @State var highScore: Int = 0
    
    var body: some View {
        //Mainly visuals on this view, all inside of a navigation view/VStack
        NavigationView{
            VStack{
                Text("Silverware Sorter").font(.largeTitle).bold()
                    .padding(.top)
                Image("angled-group")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("The dishes are ready.").font(.title2)
                    .multilineTextAlignment(.center)
                Text("Are you?").font(.title2).italic()
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Spacer()
                //Play button navigates to the Sorting Center- where all the magic happens.
                NavigationLink(
                    destination: SortingCenter(highScore: $highScore)
                        //Remove unecessary spaces
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    ,
                    label: {
                        Image(systemName: "play.fill").resizable()
                            .frame(width: 50, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.gray)
                            .shadow(radius: 10)
                            .padding()
                    })
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                Spacer()
                HStack{
                    Text("My All-Time High Score:")
                    Text("\(highScore)")
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
