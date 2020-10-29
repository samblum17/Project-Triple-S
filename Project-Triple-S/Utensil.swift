//
//  Utensil.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

enum DragState {
    case unknown
    case good
    case bad
}

//View of a single utensil
struct Utensil: View {
    @State var utensil: String
    static let fork = "fork-shadow"
    static let knife = "knife-shadow"
    static let spoon = "spoon-shadow"
    @Binding var forkScore: Int
    @Binding var knifeScore: Int
    @Binding var spoonScore: Int
    @Binding var totalScore: Int
    
    @State private var dragAmount = CGSize.zero
    @State private var dragState = DragState.unknown
    var onChanged: ((CGPoint, String) -> DragState)?
    
    var body: some View {
        Image(self.utensil)
            .resizable()
            .scaledToFill()
            .offset(dragAmount)
            .zIndex(dragAmount == .zero ? 0 : 1)
            .shadow(color: dragColor, radius: dragAmount == .zero ? 0 : 10)
            .gesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                        self.dragState = self.onChanged?($0.location, self.utensil) ?? .unknown
                    }
                    .onEnded { _ in
                        if dragState == .good {
                            totalScore += 1
                            switch self.utensil {
                            case Utensil.fork:
                                forkScore += 1
                            case Utensil.knife:
                                knifeScore += 1
                            case Utensil.spoon:
                                spoonScore += 1
                            default:
                                break
                            }
                        } else {
                            self.dragAmount = .zero
                        }
                    }
            )
    }

    
    //getRandomUtensil- Returns a new random utensil image each call
    func getRandomUtensil() -> String {
        let utensils: Set<String> = [Utensil.fork, Utensil.knife, Utensil.spoon]
        //Below is always going to return a random element and never going to default to fork but, just for my own sanity, I dont want to force unwrap in such a seriously intense game. There's a lot at stake here
        return utensils.randomElement() ?? Utensil.fork
    }
    
    var dragColor:Color {
        switch dragState{
        case .unknown:
            return .gray
        case .good:
            return .green
        case .bad:
            return .red
        }
    }
}

struct Utensil_Previews: PreviewProvider {
    static var previews: some View {
        Utensil(utensil: Utensil.fork, forkScore: .constant(10), knifeScore: .constant(10), spoonScore: .constant(10), totalScore: .constant(10))
    }
}
