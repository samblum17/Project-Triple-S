//
//  SurvivorSortingCenter.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 11/05/20.
//

import SwiftUI

//The true beef of the game. This is where the magic happens.
struct SurvivorSortingCenter: View {
    //Variables to hold always on-screen objects
    @State private var drawerFrames = [CGRect](repeating: .zero, count: 3)
    @State private var drawerOrigins = [CGPoint](repeating: .zero, count: 3)
    private var drawers: [String] = ["fork-drawer", "knife-drawer", "spoon-drawer"]
    private var possibleUtensils: [String] = [Utensil.fork, Utensil.knife, Utensil.spoon]
    
    //Variables to manage gameplay
    @State private var pauseShowing = false
    @State private var gameOverShowing = false
    @State private var gameTimer = GameTimer(gameOverShowing: .constant(false))
    @State private var timeRemaining = 2 //Keep track of changing survivorTimer time for when to show GameOver

    @State private var forkScore: Int = 0
    @State private var knifeScore: Int = 0
    @State private var spoonScore: Int = 0
    @State private var totalScore: Int = 0
    @AppStorage("highScore", store: UserDefaults(suiteName: ContentView.appGroup)) var highScore: Int = 0
    @AppStorage("survivorMode", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorMode: Bool = false
    @AppStorage("survivorHighScore", store: UserDefaults(suiteName: ContentView.appGroup)) var survivorHighScore: Int = 0
    
    //Constants for readability
    let drawerCoordinates = "drawer-space"
    let vStackCoordinates = "vstack-space"
    let drawerCenterXOffset: CGFloat = -5
    
    var body: some View {
        //Start by generating a new utensil every time view refreshes (on score change/utensil drops)
        //Maintain in an array for future game modes
        let unsortedUtensils: [Utensil] = [Utensil(utensil: getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, drawerOrigins: $drawerOrigins, onChanged: utensilMoved, onEnded: utensilDropped, gameTimer: $gameTimer, timeRemaining: $timeRemaining, gameOverShowing: $gameOverShowing)]
        
        //Views are all contained in parent ZStack
        ZStack{
            //Show menus based on state
            if pauseShowing {
                PauseMenu(pauseShowing: $pauseShowing, timeRemaining: $timeRemaining, gameTimer: $gameTimer).zIndex(2.0).onAppear{
                    playInfiniteSound(sound: "sorting-track", type: ".wav", status: false)
                }
            }
            if gameOverShowing {
                GameOver(totalScore: $totalScore, highScore: highScore, gameOverShowing: self.$gameOverShowing).zIndex(2.0)
            }
            
            //Gameplay views are contained in VStack
            VStack(alignment: .center) {
                //Scores
                HStack(spacing: 100) {
                    Text("\(forkScore)").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title2), relativeTo: .title2))
                    Text("\(knifeScore)").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title2), relativeTo: .title2))
                    Text("\(spoonScore)").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title2), relativeTo: .title2))
                }.padding()
                
                
                //Drawers with dropped utensils placed on top
                //Shadow grows as utensils are dropped, only shown once score>=1
                ZStack {
                    HStack(spacing: 0) {
                        Image(Utensil.fork)
                            .resizable()
                            .scaledToFill()
                            .position(drawerOrigins.first ?? CGPoint())
                            .opacity(forkScore >= 1 ? 1 : 0)
                            .shadow(color: Color.black, radius: CGFloat(forkScore*2))
                        Image(Utensil.knife)
                            .resizable()
                            .scaledToFill()
                            .position(drawerOrigins.first ?? CGPoint())
                            .opacity(knifeScore >= 1 ? 1 : 0)
                            .shadow(color: Color.black, radius: CGFloat(knifeScore*2))
                        Image(Utensil.spoon)
                            .resizable()
                            .scaledToFill()
                            .position(drawerOrigins.first ?? CGPoint())
                            .opacity(spoonScore >= 1 ? 1 : 0)
                            .shadow(color: Color.black, radius: CGFloat(spoonScore*2))
                    }.scaledToFit().zIndex(0.5)
                    
                    //Drawers
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
                                            //Set frames and origins for checking valid placements in methods
                                            self.drawerFrames[utensil] = location.frame(in: .global)
                                            self.drawerOrigins[utensil] = CGPoint(x: location.frame(in: .named(drawerCoordinates)).midX, y: location.frame(in: .named(drawerCoordinates)).midY)
                                        }
                                }
                                )
                        }
                    }.scaledToFit()
                    .coordinateSpace(name: drawerCoordinates) //Set frame of reference
                }
                
                
                //Unsorted utensils
                HStack(alignment: .center) {
                    //Continuously update and show new utensils as current one is placed
                    ForEach(unsortedUtensils, id:\.self) { utensil in
                        utensil
                    }
                    //Disable dragging when game is paused/over
                    .allowsHitTesting(!gameOverShowing && !pauseShowing)
                }
                .scaledToFit()
                .edgesIgnoringSafeArea(.horizontal)
            }
            .coordinateSpace(name: vStackCoordinates) //Set frame of reference
            
            
            //Timer and pause button
            VStack {
                ZStack{
                    Image("plate")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .colorMultiply(.gray)
                        Text("☠️").font(Font.custom("Chalkboard", size: ContentView.textSize(textStyle: .title1), relativeTo: .largeTitle))
                        .onReceive(gameTimer.timer, perform: { _ in
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
            }
            //Anchor to bottom left of ZStack
            .if(!ProcessInfo.processInfo.isiOSAppOnMac){value in value.offset(x: -UIScreen.main.bounds.width/3, y: UIScreen.main.bounds.height/3.3).padding()}
            .if(ProcessInfo.processInfo.isiOSAppOnMac){value in value.offset(x: -UIScreen.main.bounds.width/5, y: UIScreen.main.bounds.height/5).padding()}
        }
        .onAppear{
            //Play game soundtrack while sorting
            playInfiniteSound(sound: "sorting-track", type: ".wav", status: true)
        }
    }
    
    
    //Helper function to track movement of current utensil and return if valid placement
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
            totalScore += 1
            return currentDrawerMid
        } else {
            gameOverShowing = true
            return CGPoint.zero
        }
        
    }
    
    //Helper function to get a new random utensil
    func getRandomUtensil() -> String {
        let utensils: Set<String> = [Utensil.fork, Utensil.knife, Utensil.spoon]
        //Below is always going to return a random utensil and never going to default to fork but, just for my own sanity, I dont want to force unwrap in such a seriously intense game. There's a lot at stake here
        return utensils.randomElement() ?? Utensil.fork
    }
    
}


//Previews
struct SurvivorSortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SurvivorSortingCenter()
    }
}
