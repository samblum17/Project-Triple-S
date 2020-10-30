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
    @State private var drawers: [String] = ["fork-drawer", "knife-drawer", "spoon-drawer"]
    @State private var possibleUtensils: [String] = [Utensil.fork, Utensil.knife, Utensil.spoon]
//    @State var unsortedUtensils: [Utensil] = [(Utensil(utensil: Utensil.getRandomUtensil(), onChanged: utensilMoved))]

    //Variables to manage gameplay
    @State private var timeRemaining = 17
    @State private var gameTimer = GameTimer()
    @State var forkScore: Int = 0
    @State var knifeScore: Int = 0
    @State var spoonScore: Int = 0
    @State var totalScore: Int = 0
    @Binding var highScore: Int
    
    
    var body: some View {
        //All views inside this VStack
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
                                        
                                        }
                                }
                                )
                    }
                }
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
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "pause.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                            .shadow(radius: 10)
                    })
                }.padding(.bottom, 55)
                
                
                //Utensils to sort
                ZStack{
                    ForEach(0..<10) { _ in
                        Utensil(utensil: Utensil.getRandomUtensil(), forkScore: $forkScore, knifeScore: $knifeScore, spoonScore: $spoonScore, totalScore: $totalScore, drawerFrames: $drawerFrames, onChanged: utensilMoved)
                    }
//                    ForEach(0..<unsortedUtensils.count) { num in
//                        unsortedUtensils[num]
//                    }
                }
                Spacer(minLength: 50)
                
                
            }.scaledToFit()
            .edgesIgnoringSafeArea(.horizontal)
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
    func utensilDropped(location: CGPoint, dropUtensil: String) {
        if let dropZone = drawerFrames.firstIndex(where: { $0.contains(location)}) {

        }
        
    }
    
}


//Previews
struct SortingCenter_Previews: PreviewProvider {
    static var previews: some View {
        SortingCenter(highScore: .constant(0))
    }
}
