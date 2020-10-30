//
//  Utensil.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//View for a single utensil
struct Utensil: View {
    @State var utensil: String
    static let fork = "fork-shadow"
    static let knife = "knife-shadow"
    static let spoon = "spoon-shadow"
    @Binding var forkScore: Int
    @Binding var knifeScore: Int
    @Binding var spoonScore: Int
    @Binding var totalScore: Int
    
    @Binding var drawerFrames: [CGRect]
    @State private var dragAmount = CGSize.zero
    @State private var dragState = DragState.unknown
    @State var dropped: Bool = false
    @State private var endPos = CGPoint.zero
    
    var onChanged: ((CGPoint, String) -> DragState)?
    var onEnded: ((CGPoint, String) -> CGPoint)?
    
    
    var body: some View {
        Image(self.utensil)
            .resizable()
            .offset(dragAmount)
            .if(dropped){$0.position(endPos)}
            .scaledToFill()
            .zIndex(dragAmount == .zero ? 0 : 1)
            .shadow(color: dragColor, radius: dragAmount == .zero ? 0 : 10)
            .zIndex(1)
            .gesture (
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                        self.dragState = self.onChanged?($0.location, self.utensil) ?? .unknown
                        
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if dragState == .good {
                                totalScore += 1
                                endPos = self.onEnded?(value.location, self.utensil) ?? CGPoint.zero
                                switch self.utensil {
                                case Utensil.fork:
                                    self.dragAmount = CGSize(width: -drawerFrames[0].width, height: -drawerFrames[0].height)
                                    forkScore += 1
                                    dropped = true
                                case Utensil.knife:
                                    self.dragAmount = CGSize(width: -drawerFrames[0].width, height: -drawerFrames[0].height)
                                    knifeScore += 1
                                    dropped = true
                                case Utensil.spoon:
                                    self.dragAmount = CGSize(width: -drawerFrames[0].width, height: -drawerFrames[0].height)
                                    spoonScore += 1
                                    dropped = true
                                default:
                                    break
                                }
                            } else {
                                self.dragAmount = .zero
                                
                            }
                        }
                    }
            )
            .allowsHitTesting(!dropped) //Disable dragging once dropped
    }
    
    
    
    
    
    
    //getRandomUtensil- Returns a new random utensil image each call
    static func getRandomUtensil() -> String {
        let utensils: Set<String> = [Utensil.fork, Utensil.knife, Utensil.spoon]
        //Below is always going to return a random element and never going to default to fork but, just for my own sanity, I dont want to force unwrap in such a seriously intense game. There's a lot at stake here
        return utensils.randomElement() ?? Utensil.fork
    }
    
    //For testing
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

//struct Utensil_Previews: PreviewProvider {
//    static var previews: some View {
////        Utensil(utensil: Utensil.fork, drawerFrames: .constant()
//    }
//}

//Enum to manage state of current utensil's drop site
enum DragState {
    case unknown
    case good
    case bad
}

//View extension for conditional modifiers
extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
