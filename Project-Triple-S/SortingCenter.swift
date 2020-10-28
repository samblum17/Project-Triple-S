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
    @State var currentUtensil = "fork-shadow"
    @Binding var highScore: Int
    @State private var timeRemaining = 17
    @State private var gameTimer = GameTimer()
    
    var body: some View {
        VStack {
            HStack(spacing: 100) {
                Text("0").font(.title2)
                Text("0").font(.title2)
                Text("0").font(.title2)
            }.padding()
            HStack(spacing: 0) {
                ForEach(0..<3) { utensil in
                    ZStack {
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
                Utensil(utensil: getRandomUtensil(), onChanged: self.utensilMoved)
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
        return utensils.randomElement() ?? "fork"
    }
    
}


struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter(highScore: .constant(100))
    }
}
