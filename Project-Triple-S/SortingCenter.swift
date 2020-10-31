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
    @State var drawerFrames = [CGRect](repeating: .zero, count: 3)
    @State var drawerOrigins = [CGPoint](repeating: .zero, count: 3)
    @State private var drawers: [String] = ["fork-drawer", "knife-drawer", "spoon-drawer"]
    @State private var possibleUtensils: [String] = [Utensil.fork, Utensil.knife, Utensil.spoon]
    @State private var unsortedUtensils: [AnyView] = []
    
    //Variables to manage gameplay
    @State private var timeRemaining = 17
    @State private var gameTimer = GameTimer()
    @State private var pauseShowing = false
    @State var forkScore: Int = 0
    @State var knifeScore: Int = 0
    @State var spoonScore: Int = 0
    @State var totalScore: Int = 0
    @Binding var highScore: Int
    
    //Constants
    let drawerCoordinates = "drawer-space"
    let vStackCoordinates = "vstack-space"
    let drawerCenterXOffset: CGFloat = -5
    
    var body: some View {
        //        ForEach(0..<10) { _ in
        //           unsortedUtensils.append(Utensil(utensil: Utensil.getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, onChanged: utensilMoved))
        //        }
        
        return Group {
            //ZStack used for pause menu overlay
            ZStack{
                if pauseShowing {
                    PauseMenu(pauseShowing: $pauseShowing).zIndex(2.0)
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
                            gameTimer
                        }
                        Button(action: {
                            self.gameTimer.timer.upstream.connect().cancel()
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
                    ZStack{
                        ForEach(0..<7) { _ in
                            Utensil(utensil: Utensil.getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, drawerOrigins: $drawerOrigins, onChanged: utensilMoved, onEnded: utensilDropped)
                                .zIndex(pauseShowing ? 0 : 1)
                        }
                    }
                    .allowsHitTesting(timeRemaining > 0)
                    Spacer(minLength: 50)
                    
                    
                }.onAppear {
                    startGame()
                }
                .scaledToFit()
                .edgesIgnoringSafeArea(.horizontal)
                
            }.coordinateSpace(name: vStackCoordinates)
            }
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
            
            for _ in 0...5 {
                unsortedUtensils.append(AnyView(Utensil(utensil: Utensil.getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, drawerOrigins: $drawerOrigins, onChanged: utensilMoved, onEnded: utensilDropped)))
            }
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
        timeRemaining = 17
        
        for _ in 0...10 {
            unsortedUtensils.append(AnyView(Utensil(utensil: Utensil.getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, drawerOrigins: $drawerOrigins,onChanged: utensilMoved, onEnded: utensilDropped)))
        }
    }
    
}

//Previews
struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter(highScore: .constant(0))
    }
}
