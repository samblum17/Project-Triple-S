//
//  SortingCenter.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//Gameplay view
struct SortingCenter: View {
    @State private var drawerFrames = [CGRect](repeating: .zero, count: 3)
    @State private var drawers: [String] = ["fork-drawer", "knife-drawer", "spoon-drawer"]
    @State private var possibleUtensils: [String] = ["fork-shadow", "knife-shadow", "spoon-shadow"]
    @State private var timeRemaining = 17
    @State private var gameTimer = GameTimer()
    @State private var forksHidden = true
    @State private var knivesHidden = true
    @State private var spoonsHidden = true
    @State var forkScore: Int = 0
    @State var knifeScore: Int = 0
    @State var spoonScore: Int = 0
    @State var totalScore: Int = 0
    @Binding var highScore: Int
    
    var body: some View {
        VStack {
            HStack(spacing: 100) {
                Text("\(forkScore)").font(.title2)
                Text("\(knifeScore)").font(.title2)
                Text("\(spoonScore)").font(.title2)
            }.padding()
            ZStack {
                HStack(spacing: 0) {
                    ForEach(0..<3) { utensil in
                        Image(drawers[utensil])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.all)
                            .overlay(GeometryReader { location in
                                Color.clear
                                    .onAppear{
                                        self.drawerFrames[utensil] = location.frame(in: .global)
                                    }
                            }
                            )
                    }
                }
            }
            HStack {
                ZStack{
                    ForEach(0..<5) { _ in
                        Utensil(utensil: getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, onChanged: self.utensilMoved)
                    }
                }
                ZStack{
                    Image("plate")
                        .resizable()
                        .frame(width: 100, height: 100)
                    gameTimer
                }
            }
        }.edgesIgnoringSafeArea(.horizontal)
    }
    
    func utensilMoved(location: CGPoint, dropUtensil: String) -> DragState {
        if let dropZone = drawerFrames.firstIndex(where: { $0.contains(location)}) {
            if possibleUtensils[dropZone] == dropUtensil {
                return .good
            } else {
                return .bad
            }
        } else {
            return .unknown
        }
    }
    
    //getRandomUtensil- Returns a new random utensil image each call
    func getRandomUtensil() -> String {
        let utensils: Set<String> = ["fork-shadow", "knife-shadow", "spoon-shadow"]
        //Below is always going to return a random element and never going to default to fork but, just for my own sanity, I dont want to force unwrap in such a seriously intense game. There's a lot at stake here
        return utensils.randomElement() ?? "fork-shadow"
    }
    
    func utensilDropped(location: CGPoint, dropUtensil: String) {
        if let dropZone = drawerFrames.firstIndex(where: { $0.contains(location)}) {

        }
        
    }
    
}


struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter(forkScore: 10, knifeScore: 10, spoonScore: 10, totalScore: 30, highScore: .constant(100))
    }
}
