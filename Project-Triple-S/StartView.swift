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
    
    var body: some View {
        //Mainly visuals on this view, all inside of a navigation view/VStack
        NavigationView{
            VStack{
                Image("angled-group")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .animation(.interpolatingSpring(stiffness: 80, damping: 3.0))
                    .zIndex(1.0)
                Spacer()
                
                Text("The silverware is ready...")
                    .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("Are you?").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.center)
                
                //Play buttons navigate to brief countdown and then progromatically to the appropiate Sorting Center- where all the magic happens.
                HStack{
                    NavigationLink(destination: Countdown()
                                    .onAppear{survivorMode = false}
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true), label: {
                                        Text("Classic Mode")
                                            .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    }
                    )
                    .buttonStyle(BorderlessButtonStyle())
                    .background(Color.gray)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                    .padding()
                    NavigationLink(destination: SurvivorCountdown()
                                    .onAppear{survivorMode = true}
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true), label: {
                                        Text("Survivor Mode")
                                            .font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .body), relativeTo: .body))
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    }
                    )
                    .buttonStyle(BorderlessButtonStyle())
                    .background(Color.gray)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                    .padding()
                }
                Spacer()
                Spacer()
                Spacer()
                
                //Help view
                VStack(alignment: .center){
                    NavigationLink(destination: Help(), label: {
                        Image(systemName: "questionmark.circle").resizable()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .foregroundColor(.init(UIColor.systemGray))
                    })
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
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
