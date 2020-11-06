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
    @AppStorage("survivorMode", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorMode: Bool = false
    @AppStorage("survivorHighScore", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorHighScore: Int = 0
    
    var foreverAnimation: Animation {
        Animation.interpolatingSpring(stiffness: 80, damping: 3.0)
    }
    
    var body: some View {
        //Mainly visuals on this view, all inside of a navigation view/VStack
        NavigationView{
            VStack{
                Image("angled-group")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .animation(.interpolatingSpring(stiffness: 80, damping: 3.0))
                Spacer()
                
                Text("The silverware is ready...")
                    .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("Are you?").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.center)
                
                //Play button navigates to brief countdown and then progromatically to the Sorting Center- where all the magic happens.
                HStack{
                NavigationLink(
                    destination: Countdown()
                        //Remove unecessary whitespace
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
                }
                Spacer()
                HStack{
                    Text("High Score:")
                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title2), relativeTo: .title2))
                    Text("\(survivorMode ? survivorHighScore : highScore)")
                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title2), relativeTo: .title2))
                    
                }.padding()
                HStack {
                    Text("Survivor Mode")
                        .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title3), relativeTo: .title3))
                    Toggle("", isOn: $survivorMode)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: .gray))
                }
                Spacer()
            }
            //Remove unecessary whitespace
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            playSound(sound: "start-chime", type: ".mp3", status: true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
