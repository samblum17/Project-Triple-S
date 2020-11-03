//
//  SortingCenter.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//Gameplay screen
struct SortingCenter: View {
    //Variables to hold objects
    @State private var drawerFrames = [CGRect](repeating: .zero, count: 3)
    @State private var drawerOrigins = [CGPoint](repeating: .zero, count: 3)
    private var drawers: [String] = ["fork-drawer", "knife-drawer", "spoon-drawer"]
    private var possibleUtensils: [String] = [Utensil.fork, Utensil.knife, Utensil.spoon]
    
//    @State private var testShow: Bool = true
    @State private var forkDepth: CGFloat = 2
    @State private var knifeDepth: CGFloat = 2
    @State private var spoonDepth: CGFloat = 2
    
    //Variables to manage gameplay
    @State private var pauseShowing = false
    @State private var gameTimer = GameTimer(gameOverShowing: .constant(false))
    @State private var timeRemaining = 17 //Keep track of changing gameTimer time to show GameOver
    @State private var gameOverShowing = false
    @State private var forkScore: Int = 0
    @State private var knifeScore: Int = 0
    @State private var spoonScore: Int = 0
    @State private var totalScore: Int = 0
    @AppStorage("highScore", store: UserDefaults(suiteName: ContentView.appGroup)) var highScore: Int = 0
    //Constants
    let drawerCoordinates = "drawer-space"
    let vStackCoordinates = "vstack-space"
    let drawerCenterXOffset: CGFloat = -5
    
    
    var body: some View {
        //Generate a new utensil every time view refreshes (on utensil drops)
        let unsortedUtensils: [Utensil] = [Utensil(utensil: getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, drawerOrigins: $drawerOrigins, onChanged: utensilMoved, onEnded: utensilDropped)]
        ZStack{
            if pauseShowing {
                PauseMenu(pauseShowing: $pauseShowing, timeRemaining: $timeRemaining, gameTimer: $gameTimer).zIndex(2.0).onAppear{
                    playSound(sound: "sorting-track", type: ".wav", status: false)
                }
            }
            if gameOverShowing {
                GameOver(totalScore: $totalScore, highScore: highScore, gameOverShowing: self.$gameOverShowing).zIndex(2.0)
            }
            //All views inside this ZStack
            VStack(alignment: .center) {
                
                //Scores
                HStack(spacing: 100) {
                    Text("\(forkScore)").font(Font.custom("Chalkboard", size: textSize(textStyle: .title2), relativeTo: .title2))
                    Text("\(knifeScore)").font(Font.custom("Chalkboard", size: textSize(textStyle: .title2), relativeTo: .title2))
                    Text("\(spoonScore)").font(Font.custom("Chalkboard", size: textSize(textStyle: .title2), relativeTo: .title2))
                }.padding()
                
                //Drawers with dropped utensils on top
                //Shadow grows as utensils are dropped, only shown once score>=1
                ZStack {
                    HStack(spacing: 0) {
                        Image(Utensil.fork)
                            .resizable()
                            .scaledToFill()
                            .position(drawerOrigins.first ?? CGPoint())
                            .opacity(forkScore >= 1 ? 1 : 0)
                            .shadow(color: Color.black, radius: forkDepth)
                        Image(Utensil.knife)
                            .resizable()
                            .scaledToFill()
                            .position(drawerOrigins.first ?? CGPoint())
                            .opacity(knifeScore >= 1 ? 1 : 0)
                            .shadow(color: Color.black, radius: knifeDepth)
                        Image(Utensil.spoon)
                            .resizable()
                            .scaledToFill()
                            .position(drawerOrigins.first ?? CGPoint())
                            .opacity(spoonScore >= 1 ? 1 : 0)
                            .shadow(color: Color.black, radius: spoonDepth)
                    }.scaledToFit().zIndex(0.5)
                    HStack(spacing: 0) {
                        ForEach(0..<3) { utensil in
                            Image(drawers[utensil])
                                .resizable()
                                .scaledToFit()
                                .edgesIgnoringSafeArea(.all)
                                .zIndex(0)
                                .overlay(GeometryReader { location in
                                    Color.clear
                                        .onAppear{
                                            self.drawerFrames[utensil] = location.frame(in: .global)
                                            self.drawerOrigins[utensil] = CGPoint(x: location.frame(in: .named(drawerCoordinates)).midX, y: location.frame(in: .named(drawerCoordinates)).midY)
                                        }
                                }
                                )
                        }
                    }.scaledToFit()
                    .coordinateSpace(name: drawerCoordinates)
                    
                }
                
                //Timer and pause

                HStack(alignment: .center, spacing: 0) {
                    VStack {
                        ZStack{
                            Image("plate")
                                .resizable()
                                .frame(width: 60, height: 60)
                            gameTimer.onReceive(gameTimer.timer, perform: { _ in
                                self.timeRemaining -= 1
                                if self.timeRemaining == 0 {
                                    gameTimer.cancelTimer()
                                    gameOverShowing = true
                                }
                            })
                        }
                        Button(action: {
                            gameTimer.cancelTimer()
                            pauseShowing = true
                        }, label: {
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                                .shadow(radius: 10)
                        })
                    }.offset()
                    
                    //Utensils to sort
                    ZStack {
                        ForEach(unsortedUtensils, id:\.self) { utensil in
                            utensil
                        }
                    }
                    .allowsHitTesting(!gameOverShowing && !pauseShowing)
                    Spacer(minLength: 50)
                }
                .scaledToFit()
                .edgesIgnoringSafeArea(.horizontal)
                
            }.coordinateSpace(name: vStackCoordinates)
        }
            .onAppear{
                playSound(sound: "sorting-track", type: ".wav", status: true)

                
            }
        }
    
    
    
    
    //Helper function to track movement of current utensil
    func utensilMoved(location: CGPoint, dropUtensil: String) -> DragState {
        if let dropZone = drawerFrames.firstIndex(where: { $0.contains(location)}) {
            let utensilSuccess = possibleUtensils[dropZone]
            if utensilSuccess == dropUtensil {
                return .good
            } else {
                return .bad
            }
        } else {
            return .unknown
        }
    }
    
    
    //Helper function to manage dropping of utensil into drawer
    func utensilDropped(location: CGPoint, dropUtensil: String) -> CGPoint {
        if let dropZone = drawerFrames.firstIndex(where: { $0.contains(location)}) {
            let currentDrawerMid = drawerOrigins[dropZone]
            switch dropUtensil {
            case Utensil.fork:
                forkDepth += 2
            case Utensil.knife:
                knifeDepth += 2
            case Utensil.spoon:
                spoonDepth += 2
            default:
                break
            }
            //Add a new utensil to unsorted
            //            unsortedUtensils.append(Utensil(utensil: getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, drawerOrigins: $drawerOrigins, onChanged: utensilMoved, onEnded: utensilDropped))
            
            
            totalScore += 1
            
            return currentDrawerMid
        } else {
            return CGPoint.zero
        }
        
    }
    
    //Helper function to get a new random utensil
    func getRandomUtensil() -> String {
        let utensils: Set<String> = [Utensil.fork, Utensil.knife, Utensil.spoon]
        //Below is always going to return a random element and never going to default to fork but, just for my own sanity, I dont want to force unwrap in such a seriously intense game. There's a lot at stake here
        return utensils.randomElement() ?? Utensil.fork
    }
    //Helper for dynamic type on custom font
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
}



//Previews
struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter()
    }
}
