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
                    .animation(foreverAnimation)
                Spacer()
                
                Text("The dishes are ready...")
                    .font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("Are you?").font(Font.custom("Chalkboard", size: textSize(textStyle: .title1), relativeTo: .title))
                    .multilineTextAlignment(.center)
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
                    Text("High Score:")
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .title2), relativeTo: .title2))
                    Text("\(highScore)")
                        .font(Font.custom("Chalkboard", size: textSize(textStyle: .title2), relativeTo: .title2))
                    
                }.padding()
                Spacer()
            }
            //Remove unecessary spaces
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            playSound(sound: "start-chime", type: ".mp3")
        }
    }
}
//Helper for dynamic type on custom font
func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
    return UIFont.preferredFont(forTextStyle: textStyle).pointSize
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
