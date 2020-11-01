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
    @State private var drawers: [String] = ["fork-drawer", "knife-drawer", "spoon-drawer"]
    @State private var possibleUtensils: [String] = [Utensil.fork, Utensil.knife, Utensil.spoon]
    @State private var unsortedUtensils: [UUID] = [UUID(), UUID()] //Store IDs in array to represent each unsorted utensil and keep track on when to add new one
    
    //Variables to manage gameplay
    @State private var pauseShowing = false
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
        ZStack{
            if pauseShowing {
                PauseMenu(pauseShowing: $pauseShowing).zIndex(2.0)
            }
            if gameOverShowing {
                GameOver(totalScore: $totalScore, highScore: highScore).zIndex(2.0)
            }
            //All views inside this ZStack
            VStack(alignment: .center) {
                
                //Scores
                HStack(spacing: 100) {
                    Text("\(forkScore)").font(.title2)
                    Text("\(knifeScore)").font(.title2)
                    Text("\(spoonScore)").font(.title2)
                }.padding()
                
                //Drawers
                ZStack {
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
                                            self.drawerOrigins[utensil] = CGPoint(x: location.frame(in: .named(drawerCoordinates)).maxX + drawerCenterXOffset, y: location.frame(in: .named(drawerCoordinates)).midY)
                                        }
                                }
                                )
                        }
                    }.scaledToFit()
                    .coordinateSpace(name: drawerCoordinates)
                }
                
                //Timer and pause
                HStack(alignment: .bottom, spacing: 0) {
                    VStack{
                        ZStack{
                            Image("plate")
                                .resizable()
                                .frame(width: 60, height: 60)
                            GameTimer(gameOverShowing: $gameOverShowing)
                        }
                        Button(action: {
                            pauseShowing = true
                        }, label: {
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                                .shadow(radius: 10)
                        })
                    }.padding(.bottom, 55)
                    //Utensils to sort
                    ZStack {
                        ForEach(0..<unsortedUtensils.count, id:\.self) { _ in
                            Utensil(utensil: Utensil.getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, drawerOrigins: $drawerOrigins, onChanged: utensilMoved, onEnded: utensilDropped)
                        }
                    }
                    .allowsHitTesting(!gameOverShowing && !pauseShowing)
                    Spacer(minLength: 50)
                }
                .scaledToFit()
                .edgesIgnoringSafeArea(.horizontal)
                
            }.coordinateSpace(name: vStackCoordinates)
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
            unsortedUtensils.append(UUID())
            return currentDrawerMid
        } else {
            return CGPoint.zero
        }
        
    }
    
    func startGame() {
        forkScore = 0
        knifeScore = 0
        spoonScore = 0
        totalScore = 0
    }
}


//Previews
struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter()
    }
}
