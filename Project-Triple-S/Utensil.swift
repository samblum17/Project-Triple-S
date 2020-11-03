//
//  Utensil.swift
//  Project-Triple-S
//
//  Created by Sam Blum on 10/27/20.
//

import SwiftUI

//View for a single utensil
struct Utensil: View, Hashable {
    //Conform to hashable to iterate over array of unsorted utensils
    static func == (lhs: Utensil, rhs: Utensil) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //General utensil properties
    var utensil: String
    var id = UUID()
    
    static let fork = "fork-shadow"
    static let knife = "knife-shadow"
    static let spoon = "spoon-shadow"
    
    //Binded to the SortingCenter
    @Binding var forkScore: Int
    @Binding var knifeScore: Int
    @Binding var spoonScore: Int
    @Binding var totalScore: Int
    @Binding var drawerFrames: [CGRect]
    @Binding var drawerOrigins: [CGPoint]
    //    @Binding var unsortedUtensils: [Utensil]
    
    //Current utensil properties
    @State private var dragAmount = CGSize.zero
    @State private var dragState = DragState.unknown
    @State var dropped: Bool = false
    @State private var endPos = CGPoint.zero
    var onChanged: ((CGPoint, String) -> DragState)?
    var onEnded: ((CGPoint, String) -> CGPoint)?
    
    //A single utensil
    var body: some View {
        Image(self.utensil)
            .resizable()
            .offset(dragAmount)
            .if(dropped){value in value.position(endPos)}
            .scaledToFill()
            .zIndex(dragAmount == .zero ? 0 : 1)
            .shadow(color: Color.black, radius: dropped ? 2 : 0)
            .gesture (
                DragGesture(coordinateSpace: .global)
                    //While dragging, update offset and state of drag
                    .onChanged {
                        self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                        self.dragState = self.onChanged?($0.location, self.utensil) ?? .unknown
                    }
                    //When dropped, check if valid, send haptic feedback, increase scores, set correct drawer position
                    .onEnded { value in
                        if dragState == .good {
                            simpleSuccess()
                            endPos = self.onEnded?(value.location, self.utensil) ?? CGPoint.zero
                            let drawerWidth = -drawerFrames[0].width //for readability
                            let drawerHeight = -drawerFrames[0].height //for readability
                            switch self.utensil {
                            case Utensil.fork:
                                self.dragAmount = CGSize(width: drawerWidth, height: drawerHeight)
                                forkScore += 1
                                dropped = true
                            case Utensil.knife:
                                self.dragAmount = CGSize(width: drawerWidth, height: drawerHeight)
                                knifeScore += 1
                                dropped = true
                            case Utensil.spoon:
                                self.dragAmount = CGSize(width: drawerWidth, height: drawerHeight)
                                spoonScore += 1
                                dropped = true
                            default:
                                break
                            }
                        } else {
                            withAnimation(.spring()) {
                                simpleFail()
                                self.dragAmount = .zero
                            }
                        }
                    }
            )
            .allowsHitTesting(!dropped) //Disable dragging once dropped
    }
    
    
    //Haptic feedback funcs
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func simpleFail() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
}

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
